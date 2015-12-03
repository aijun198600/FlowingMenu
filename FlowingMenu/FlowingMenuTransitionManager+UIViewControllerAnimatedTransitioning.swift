/*
 * FlowingMenu
 *
 * Copyright 2015-present Yannick Loriot.
 * http://yannickloriot.com
 *
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to deal
 * in the Software without restriction, including without limitation the rights
 * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included in
 * all copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 * THE SOFTWARE.
 *
 */

import UIKit

/**
Conforming to the `UIViewControllerAnimatedTransitioning` protocol to manage the
 transition animation.
*/
extension FlowingMenuTransitionManager: UIViewControllerAnimatedTransitioning {
  public func animateTransition(context: UIViewControllerContextTransitioning) {
    let fromVC = context.viewControllerForKey(UITransitionContextFromViewControllerKey)!
    let toVC   = context.viewControllerForKey(UITransitionContextToViewControllerKey)!

    let containerView = context.containerView()!
    let menuView      = animationMode == .Presentation ? toVC.view : fromVC.view
    let otherView     = animationMode == .Presentation ? fromVC.view : toVC.view

    let action = animationMode == .Presentation ? presentMenu : dismissMenu

    action(menuView, otherView: otherView, containerView: containerView, context: context, duration: transitionDuration(context)) {
      context.completeTransition(!context.transitionWasCancelled())
    }
  }

  public func transitionDuration(context: UIViewControllerContextTransitioning?) -> NSTimeInterval {
    return interactive ? 0.6 : 0.2
  }
}