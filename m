Received: from mail-106112.protonmail.ch (mail-106112.protonmail.ch [79.135.106.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2B2C15A86D;
	Tue, 28 Jul 2026 06:12:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.135.106.112
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785219131; cv=none; b=XYetkET6ufLD/K6eMAkMep66GAzSeCOOVqsEFTA8VibPIj7YW80arye2T+FDNlw2fWjEyj1bUpQin6QNtjdqjkv2bcgPuMcGS81jRSHcr2VGSN7mphSE9u3g2FvOGooKHzLZVmiEk+XDDFNked/Z/PDn4nDH6VXhOPuX6usm5b0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785219131; c=relaxed/simple;
	bh=CaaInSiJi3i41/gut0Gwk+pfrc1/6h4OTQa64N0MPe0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uvXY/Bkj6PSLB6x7V59SCIXKw1eAYp1RE2OR2fQ35TiOKoGNWNlIU3zSnj45w30m+O2NhYBoe1x364alXA0MwczPar7yv72nrrWyTb63kDxc4lIZgK+skh7vf29DbFULilTOLUvTlhaxNwU0ePcRa5xHH7Q01mbfZOZTLAVZ7B8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=onurozkan.dev; spf=pass smtp.mailfrom=onurozkan.dev; dkim=pass (2048-bit key) header.d=onurozkan.dev header.i=@onurozkan.dev header.b=LIDFlWv8; arc=none smtp.client-ip=79.135.106.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=onurozkan.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=onurozkan.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=onurozkan.dev header.i=@onurozkan.dev header.b="LIDFlWv8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=onurozkan.dev;
	s=protonmail; t=1785219117; x=1785478317;
	bh=YlrIZYvOtDdb3cK3NLM5v5muIPdxdyD9BqDWD4Jsznc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:From:To:
	 Cc:Date:Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=LIDFlWv89QOxlHngWKelxX57/eOF58gacptBKPmXlJaaG15Uo50j9OI6zyAjU6V07
	 qMjKxluW3mN3//vtfN3Ls/TJYDbPaxKVZ3fAiRRb4kHzx8/MuxO7FnvwcwGTelyFDn
	 3MjaXKidWDLhSuyQeJJyz6LMHhvF9WLvW2QGP5l/oRC+pEDFQDhMGE5p7RUjSfSew8
	 1u3q8HbnWC/sJM71K4/H5fLclsd6TJnGLtWdrqqcwaOGp3Nf2WpQ0re5S5vvisMHC9
	 bQEVzY6Y87RTr08DWNL5J89qgkrO3VMvu1A5vgV583Ue99deH0LO4YBXEXcBNOIzcY
	 JmFU4JTQhL9+w==
X-Pm-Submission-Id: 4h8Q8k6zQCz2ScQ5
From: =?UTF-8?q?Onur=20=C3=96zkan?= <work@onurozkan.dev>
To: Danilo Krummrich <dakr@kernel.org>
Cc: gregkh@linuxfoundation.org,
	arve@android.com,
	tkjos@android.com,
	brauner@kernel.org,
	cmllamas@google.com,
	aliceryhl@google.com,
	boqun@kernel.org,
	gary@garyguo.net,
	lyude@redhat.com,
	daniel.almeida@collabora.com,
	juri.lelli@redhat.com,
	vincent.guittot@linaro.org,
	dietmar.eggemann@arm.com,
	rostedt@goodmis.org,
	bsegall@google.com,
	mgorman@suse.de,
	vschneid@redhat.com,
	kprateek.nayak@amd.com,
	ojeda@kernel.org,
	bjorn3_gh@protonmail.com,
	lossin@kernel.org,
	a.hindborg@kernel.org,
	tmgross@umich.edu,
	tamird@kernel.org,
	acourbot@nvidia.com,
	peterz@infradead.org,
	mingo@redhat.com,
	will@kernel.org,
	longman@redhat.com,
	viro@zeniv.linux.org.uk,
	jack@suse.cz,
	tj@kernel.org,
	jiangshanlai@gmail.com,
	linux-kernel@vger.kernel.org,
	rust-for-linux@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 3/5] rust: sync: add WaitQueue infrastructure
Date: Tue, 28 Jul 2026 09:11:46 +0300
Message-ID: <20260728061150.206946-1-work@onurozkan.dev>
X-Mailer: git-send-email 2.51.2
In-Reply-To: <20260726223613.1242940-4-dakr@kernel.org>
References: <20260726223613.1242940-1-dakr@kernel.org> <20260726223613.1242940-4-dakr@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Mon, 27 Jul 2026 00:36:09 +0200=0D
Danilo Krummrich <dakr@kernel.org> wrote:=0D
=0D
> Implement a wait queue wrapping the kernel's struct wait_queue_head,=0D
> with wait_event()-style methods that take a condition closure directly.=0D
> =0D
> The API mirrors the C wait_event() family:=0D
> =0D
>   - wait_event()=0D
>   - wait_event_interruptible()=0D
>   - wait_event_timeout()=0D
>   - wait_event_interruptible_timeout()=0D
>   - wake_up() / wake_up_all() / wake_up_sync()=0D
> =0D
> Interruptible and timeout variants return Result<(), WaitError>, where=0D
> WaitError maps to ERESTARTSYS (signal) or ETIMEDOUT (timeout).=0D
> =0D
> Signed-off-by: Danilo Krummrich <dakr@kernel.org>=0D
> ---=0D
>  rust/kernel/sync.rs      |   6 +=0D
>  rust/kernel/sync/wait.rs | 388 +++++++++++++++++++++++++++++++++++++++=0D
>  2 files changed, 394 insertions(+)=0D
>  create mode 100644 rust/kernel/sync/wait.rs=0D
> =0D
> diff --git a/rust/kernel/sync.rs b/rust/kernel/sync.rs=0D
> index df4f2604ff9b..31f0999e5747 100644=0D
> --- a/rust/kernel/sync.rs=0D
> +++ b/rust/kernel/sync.rs=0D
> @@ -21,6 +21,7 @@=0D
>  pub mod rcu;=0D
>  mod refcount;=0D
>  mod set_once;=0D
> +mod wait;=0D
>  =0D
>  pub use arc::{Arc, ArcBorrow, UniqueArc};=0D
>  pub use completion::Completion;=0D
> @@ -38,6 +39,11 @@=0D
>  pub use locked_by::LockedBy;=0D
>  pub use refcount::Refcount;=0D
>  pub use set_once::SetOnce;=0D
> +pub use wait::{=0D
> +    new_waitqueue,=0D
> +    WaitError,=0D
> +    WaitQueue, //=0D
> +};=0D
>  =0D
>  /// Represents a lockdep class.=0D
>  ///=0D
> diff --git a/rust/kernel/sync/wait.rs b/rust/kernel/sync/wait.rs=0D
> new file mode 100644=0D
> index 000000000000..ba4ee0f8d4d4=0D
> --- /dev/null=0D
> +++ b/rust/kernel/sync/wait.rs=0D
> @@ -0,0 +1,388 @@=0D
> +// SPDX-License-Identifier: GPL-2.0=0D
> +=0D
> +//! Wait queue.=0D
> +//!=0D
> +//! C header: [`include/linux/wait.h`](srctree/include/linux/wait.h)=0D
> +=0D
> +use super::LockClassKey;=0D
> +use crate::{=0D
> +    prelude::*,=0D
> +    str::CStr,=0D
> +    task::{=0D
> +        self,=0D
> +        TASK_INTERRUPTIBLE,=0D
> +        TASK_NORMAL,=0D
> +        TASK_UNINTERRUPTIBLE, //=0D
> +    },=0D
> +    time::Jiffies,=0D
> +    types::Opaque,=0D
> +};=0D
> +=0D
> +use core::{=0D
> +    pin::Pin,=0D
> +    ptr, //=0D
> +};=0D
> +=0D
> +/// Creates a [`WaitQueue`] initialiser with the given name and a newly-=
created lock class.=0D
> +#[macro_export]=0D
> +macro_rules! new_waitqueue {=0D
> +    ($($name:literal)?) =3D> {=0D
> +        $crate::sync::WaitQueue::new(=0D
> +            $crate::optional_name!($($name)?),=0D
> +            $crate::static_lock_class!(),=0D
> +        )=0D
> +    };=0D
> +}=0D
> +pub use new_waitqueue;=0D
> +=0D
> +/// Exposes the kernel's [`struct wait_queue_head`] as a Rust wait queue=
.=0D
> +///=0D
> +/// A `WaitQueue` allows a thread to sleep until a caller-supplied condi=
tion becomes true,=0D
> +/// re-checking the condition on each wake-up. This matches the C `wait_=
event()` family of macros.=0D
> +///=0D
> +/// For waiting with a lock guard (the condition variable pattern), use =
[`CondVar`](super::CondVar)=0D
> +/// instead.=0D
> +///=0D
> +/// Instances of `WaitQueue` need a lock class and to be pinned. The rec=
ommended way to create such=0D
> +/// instances is with the [`pin_init!`] and [`new_waitqueue!`] macros.=0D
> +///=0D
> +/// # Examples=0D
> +///=0D
> +/// ```=0D
> +/// use kernel::sync::{=0D
> +///     atomic::{=0D
> +///         Atomic,=0D
> +///         Relaxed,=0D
> +///     },=0D
> +///     new_waitqueue,=0D
> +///     WaitQueue,=0D
> +/// };=0D
> +///=0D
> +/// #[pin_data]=0D
> +/// pub struct Example {=0D
> +///     value: Atomic<i32>,=0D
> +///     #[pin]=0D
> +///     queue: WaitQueue,=0D
> +/// }=0D
> +///=0D
> +/// fn wait_for_value(e: &Example, v: i32) {=0D
> +///     e.queue.wait_event(|| e.value.load(Relaxed) =3D=3D v);=0D
> +/// }=0D
> +///=0D
> +/// fn set_value(e: &Example, v: i32) {=0D
> +///     e.value.store(v, Relaxed);=0D
> +///     e.queue.wake_up();=0D
> +/// }=0D
> +/// ```=0D
> +///=0D
> +/// [`struct wait_queue_head`]: srctree/include/linux/wait.h=0D
> +#[pin_data]=0D
> +pub struct WaitQueue {=0D
> +    #[pin]=0D
> +    wait_queue_head: Opaque<bindings::wait_queue_head>,=0D
> +}=0D
> +=0D
> +// SAFETY: `WaitQueue` only uses a `struct wait_queue_head`, which is sa=
fe to use on any thread.=0D
> +unsafe impl Send for WaitQueue {}=0D
> +=0D
> +// SAFETY: `WaitQueue` only uses a `struct wait_queue_head`, which is sa=
fe to use on multiple=0D
> +// threads concurrently.=0D
> +unsafe impl Sync for WaitQueue {}=0D
> +=0D
> +impl WaitQueue {=0D
> +    /// Constructs a new wait queue initialiser.=0D
> +    pub fn new(name: &'static CStr, key: Pin<&'static LockClassKey>) -> =
impl PinInit<Self> {=0D
> +        pin_init!(Self {=0D
> +            // SAFETY: `slot` is valid while the closure is called and b=
oth `name` and `key` have=0D
> +            // static lifetimes so they live indefinitely.=0D
> +            wait_queue_head <- Opaque::ffi_init(|slot| unsafe {=0D
> +                bindings::__init_waitqueue_head(slot, name.as_char_ptr()=
, key.as_ptr())=0D
> +            }),=0D
> +        })=0D
> +    }=0D
> +=0D
> +    /// Returns a raw pointer to the underlying `wait_queue_head`.=0D
> +    #[expect(unused)]=0D
> +    #[inline]=0D
> +    pub(super) fn as_raw(&self) -> *mut bindings::wait_queue_head {=0D
> +        self.wait_queue_head.get()=0D
> +    }=0D
> +=0D
> +    /// Sleeps until the condition returns `true`.=0D
> +    ///=0D
> +    /// The condition is checked before each sleep and after each wake-u=
p. The wait is=0D
> +    /// uninterruptible.=0D
> +    #[inline]=0D
> +    pub fn wait_event<F: Fn() -> bool>(&self, condition: F) {=0D
> +        self.wait_event_timeout_internal(TASK_UNINTERRUPTIBLE, &conditio=
n, Jiffies::MAX);=0D
> +    }=0D
> +=0D
> +    /// Sleeps until the condition returns `true` or a signal is receive=
d.=0D
> +    ///=0D
> +    /// Returns `Ok(())` when the condition is met, or `Err(WaitError::S=
ignal)` if interrupted=0D
> +    /// by a signal.=0D
> +    #[inline]=0D
> +    pub fn wait_event_interruptible<F: Fn() -> bool>(&self, condition: F=
) -> Result<(), WaitError> {=0D
> +        self.wait_event_timeout_internal(TASK_INTERRUPTIBLE, &condition,=
 Jiffies::MAX);=0D
> +        if !condition() && current!().signal_pending() {=0D
> +            Err(WaitError::Signal)=0D
> +        } else {=0D
> +            Ok(())=0D
> +        }=0D
> +    }=0D
> +=0D
> +    /// Sleeps until the condition returns `true` or the timeout expires=
.=0D
> +    ///=0D
> +    /// Returns `Ok(())` when the condition is met, or `Err(WaitError::T=
imeout)` if the timeout=0D
> +    /// elapsed first.=0D
> +    #[inline]=0D
> +    pub fn wait_event_timeout<F: Fn() -> bool>(=0D
> +        &self,=0D
> +        condition: F,=0D
> +        jiffies: Jiffies,=0D
> +    ) -> Result<(), WaitError> {=0D
> +        let remaining =3D self.wait_event_timeout_internal(TASK_UNINTERR=
UPTIBLE, &condition, jiffies);=0D
> +        if remaining =3D=3D 0 && !condition() {=0D
> +            Err(WaitError::Timeout)=0D
> +        } else {=0D
> +            Ok(())=0D
> +        }=0D
> +    }=0D
> +=0D
> +    /// Sleeps until the condition returns `true`, a signal is received,=
 or the timeout expires.=0D
> +    ///=0D
> +    /// Returns `Ok(())` when the condition is met, or `Err(WaitError)` =
on signal or timeout.=0D
> +    #[inline]=0D
> +    pub fn wait_event_interruptible_timeout<F: Fn() -> bool>(=0D
> +        &self,=0D
> +        condition: F,=0D
> +        jiffies: Jiffies,=0D
> +    ) -> Result<(), WaitError> {=0D
> +        let remaining =3D self.wait_event_timeout_internal(TASK_INTERRUP=
TIBLE, &condition, jiffies);=0D
> +        if condition() {=0D
> +            Ok(())=0D
> +        } else if current!().signal_pending() {=0D
> +            Err(WaitError::Signal)=0D
> +        } else if remaining =3D=3D 0 {=0D
> +            Err(WaitError::Timeout)=0D
> +        } else {=0D
> +            Ok(())=0D
> +        }=0D
> +    }=0D
> +=0D
> +    fn wait_event_timeout_internal(=0D
> +        &self,=0D
> +        wait_state: c_int,=0D
> +        condition: &dyn Fn() -> bool,=0D
> +        jiffies: Jiffies,=0D
> +    ) -> Jiffies {=0D
=0D
Would it make sense to check condition() first and return early?=0D
=0D
> +        let wait =3D Opaque::<bindings::wait_queue_entry>::uninit();=0D
> +=0D
> +        // SAFETY: `wait` points to valid memory.=0D
> +        unsafe { bindings::init_wait(wait.get()) };=0D
> +=0D
> +        let mut remaining =3D jiffies;=0D
> +=0D
> +        loop {=0D
> +            // SAFETY: Both `wait` and `wait_queue_head` point to valid =
memory, and `wait` was=0D
> +            // initialised by `init_wait()` above.=0D
> +            let ret =3D unsafe {=0D
> +                bindings::prepare_to_wait_event(self.wait_queue_head.get=
(), wait.get(), wait_state)=0D
> +            };=0D
> +=0D
> +            if condition() {=0D
> +                break;=0D
> +            }=0D
> +=0D
> +            if ret !=3D 0 || remaining =3D=3D 0 {=0D
> +                break;=0D
> +            }=0D
> +=0D
> +            remaining =3D task::schedule_timeout(remaining);=0D
> +=0D
> +            if condition() {=0D
> +                break;=0D
> +            }=0D
> +        }=0D
> +=0D
> +        // SAFETY: Both `wait` and `wait_queue_head` point to valid memo=
ry.=0D
> +        unsafe { bindings::finish_wait(self.wait_queue_head.get(), wait.=
get()) };=0D
> +=0D
> +        remaining=0D
> +    }=0D
> +=0D
> +    /// Performs a single exclusive prepare-to-wait / finish-wait cycle,=
 calling `schedule_fn`=0D
> +    /// in between.=0D
> +    #[expect(unused)]=0D
> +    pub(super) fn wait_once_exclusive<F, R>(&self, wait_state: c_int, sc=
hedule_fn: F) -> R=0D
> +    where=0D
> +        F: FnOnce() -> R,=0D
> +    {=0D
> +        let wait =3D Opaque::<bindings::wait_queue_entry>::uninit();=0D
> +=0D
> +        // SAFETY: `wait` points to valid memory.=0D
> +        unsafe { bindings::init_wait(wait.get()) };=0D
> +=0D
> +        // SAFETY: Both `wait` and `wait_queue_head` point to valid memo=
ry.=0D
> +        unsafe {=0D
> +            bindings::prepare_to_wait_exclusive(self.wait_queue_head.get=
(), wait.get(), wait_state)=0D
> +        };=0D
> +=0D
> +        let ret =3D schedule_fn();=0D
> +=0D
> +        // SAFETY: Both `wait` and `wait_queue_head` point to valid memo=
ry.=0D
> +        unsafe { bindings::finish_wait(self.wait_queue_head.get(), wait.=
get()) };=0D
> +=0D
> +        ret=0D
> +    }=0D
> +=0D
> +    /// Wakes up waiters.=0D
> +    ///=0D
> +    /// Wakes all non-exclusive waiters and one exclusive waiter, if any=
.  Matches C's `wake_up()`.=0D
> +    #[inline]=0D
> +    pub fn wake_up(&self) {=0D
> +        // SAFETY: `wait_queue_head` points to valid memory.=0D
> +        unsafe { bindings::__wake_up(self.wait_queue_head.get(), TASK_NO=
RMAL, 1, ptr::null_mut()) };=0D
> +    }=0D
> +=0D
> +    /// Wakes up all waiters.=0D
> +    ///=0D
> +    /// Wakes all non-exclusive and all exclusive waiters, if any.=0D
> +    /// Matches C's `wake_up_all()`.=0D
> +    #[inline]=0D
> +    pub fn wake_up_all(&self) {=0D
> +        // SAFETY: `wait_queue_head` points to valid memory.=0D
> +        unsafe { bindings::__wake_up(self.wait_queue_head.get(), TASK_NO=
RMAL, 0, ptr::null_mut()) };=0D
> +    }=0D
> +=0D
> +    /// Like [`wake_up()`](Self::wake_up), but hints to the scheduler th=
at the current task is=0D
> +    /// about to sleep, so the woken task should be scheduled on the sam=
e CPU to avoid unnecessary=0D
> +    /// migration. Matches C's `wake_up_sync()`.=0D
> +    #[inline]=0D
> +    pub fn wake_up_sync(&self) {=0D
> +        // SAFETY: `wait_queue_head` points to valid memory.=0D
> +        unsafe { bindings::__wake_up_sync(self.wait_queue_head.get(), TA=
SK_NORMAL) };=0D
> +    }=0D
> +=0D
> +    /// Wakes up all waiters and clears poll registrations.=0D
> +    ///=0D
> +    /// Used when a wait queue is about to be freed, to ensure epoll ite=
ms are properly removed.=0D
> +    /// Matches C's `wake_up_pollfree()`.=0D
> +    #[inline]=0D
> +    #[expect(unused)]=0D
> +    pub(super) fn wake_up_pollfree(&self) {=0D
> +        // SAFETY: `wait_queue_head` points to valid memory.=0D
> +        unsafe { bindings::__wake_up_pollfree(self.wait_queue_head.get()=
) };=0D
> +    }=0D
> +}=0D
> +=0D
> +/// Error returned by [`WaitQueue`] wait functions.=0D
> +#[derive(Debug, PartialEq)]=0D
> +pub enum WaitError {=0D
> +    /// Interrupted by a signal.=0D
> +    Signal,=0D
> +    /// The timeout elapsed without the condition being met.=0D
> +    Timeout,=0D
> +}=0D
> +=0D
> +impl From<WaitError> for Error {=0D
> +    #[inline]=0D
> +    fn from(e: WaitError) -> Error {=0D
> +        match e {=0D
> +            WaitError::Signal =3D> ERESTARTSYS,=0D
> +            WaitError::Timeout =3D> ETIMEDOUT,=0D
> +        }=0D
> +    }=0D
> +}=0D
> +=0D
> +#[macros::kunit_tests(rust_waitqueue)]=0D
> +mod tests {=0D
> +    use super::*;=0D
> +    use crate::{=0D
> +        sync::{=0D
> +            atomic::{=0D
> +                Atomic,=0D
> +                Relaxed, //=0D
> +            },=0D
> +            Arc,=0D
> +        },=0D
> +        time::{=0D
> +            delay::fsleep,=0D
> +            Delta, //=0D
> +        },=0D
> +        workqueue,=0D
> +    };=0D
> +=0D
> +    #[pin_data]=0D
> +    struct State {=0D
> +        value: Atomic<i32>,=0D
> +        #[pin]=0D
> +        wq: WaitQueue,=0D
> +    }=0D
> +=0D
> +    impl State {=0D
> +        fn new() -> Result<Arc<Self>> {=0D
> +            Arc::pin_init(=0D
> +                pin_init!(Self {=0D
> +                    value: Atomic::new(0),=0D
> +                    wq <- new_waitqueue!(),=0D
> +                }),=0D
> +                GFP_KERNEL,=0D
> +            )=0D
> +        }=0D
> +    }=0D
> +=0D
> +    #[test]=0D
> +    fn wait_event_from_work() {=0D
> +        let s =3D State::new().unwrap();=0D
> +=0D
> +        let s2 =3D s.clone();=0D
> +        workqueue::system_dfl()=0D
> +            .try_spawn(GFP_KERNEL, move || {=0D
> +                s2.value.store(1, Relaxed);=0D
> +                s2.wq.wake_up();=0D
> +            })=0D
> +            .unwrap();=0D
> +=0D
> +        s.wq.wait_event(|| s.value.load(Relaxed) =3D=3D 1);=0D
> +        assert_eq!(s.value.load(Relaxed), 1);=0D
> +    }=0D
> +=0D
> +    #[test]=0D
> +    fn wait_event_condition_already_true() {=0D
> +        let s =3D State::new().unwrap();=0D
> +        s.value.store(1, Relaxed);=0D
> +=0D
> +        s.wq.wait_event(|| s.value.load(Relaxed) =3D=3D 1);=0D
> +        assert_eq!(s.value.load(Relaxed), 1);=0D
> +    }=0D
> +=0D
> +    #[test]=0D
> +    fn wait_event_condition_not_yet_met() {=0D
> +        let s =3D State::new().unwrap();=0D
> +=0D
> +        let s2 =3D s.clone();=0D
> +        workqueue::system_dfl()=0D
> +            .try_spawn(GFP_KERNEL, move || {=0D
> +                s2.value.store(1, Relaxed);=0D
> +                s2.wq.wake_up_all();=0D
> +=0D
> +                fsleep(Delta::from_millis(50));=0D
> +=0D
> +                s2.value.store(2, Relaxed);=0D
> +                s2.wq.wake_up_all();=0D
> +            })=0D
> +            .unwrap();=0D
> +=0D
> +        s.wq.wait_event(|| s.value.load(Relaxed) =3D=3D 2);=0D
> +        assert_eq!(s.value.load(Relaxed), 2);=0D
> +    }=0D
> +=0D
> +    #[test]=0D
> +    fn wait_event_timeout_expires() {=0D
> +        let s =3D State::new().unwrap();=0D
> +=0D
> +        let ret =3D s.wq.wait_event_timeout(|| s.value.load(Relaxed) =3D=
=3D 1, 1);=0D
> +        assert_eq!(ret, Err(WaitError::Timeout));=0D
> +    }=0D
> +}=0D
> -- =0D
> 2.55.0=0D
> =0D
