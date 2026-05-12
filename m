Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CFD426D4F9;
	Tue, 12 May 2026 12:29:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778588950; cv=none; b=A5hK8DUmzDAkQBEnzHukyBPaKk3Rm93z9953i/gwJ53hyvics0mBo3Mncwr2PqJjup51QEOr8e609hWuGbr99RyxvTLfyXBQT767KC2uk4drO8mwCZ1N7FykVP3blEvziLqunKMhxPxHRD85Dp1afoj56tvbL2np9bnudLEOJV4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778588950; c=relaxed/simple;
	bh=OxSg6AVJlEx4U4yVifjeaZgr8UBLtt+wMeKzFB0jhxc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Dkw06CbdSNz12+rZKlh2rVmL/kEXaXxLPH+G8onu2uMhQKQzSkUndnHxo1KZeAZMSWQR9vLP/auY6m02d7RKK0DM+K48xEyNKCDyUgyCtPYbWO1m2U9Ntt9SovIA5F3WrgchJrRaPjZ8ey5+bxHTEXzNe2z6WhfpFJXyERvbX0A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W0CYu64b; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W0CYu64b"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77947C2BCB0;
	Tue, 12 May 2026 12:29:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778588949;
	bh=OxSg6AVJlEx4U4yVifjeaZgr8UBLtt+wMeKzFB0jhxc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=W0CYu64bq8AEczE5gMq7eDDuWNM8rKKp7325OIC8vWsmBaq4v09HzDHwFDS/F7l1u
	 hTtlderEu5G4HT24WwMr5gDaUPx4IYXfV7IJFXrSJgxwXHoIWO0dcSd5IWB0RKLTKl
	 fYSnxx6p8uQU7+brUEi7/yPRgdxtO6fD/yzh6IKwnnwrLIsUXU7/kLPRpTbUyKGwts
	 f3RQU31sARRPepZBDOy1PxpO3x6YoehUAvFYwI/hahshJbF/Ba5FfoJWcDjEBymkYu
	 bul6B45D4Ac2Qv8gGIz24JQXZnWZ/9lUUmMh1r5XRmyKasLK3jctseRzibQGGaOZ0N
	 OE4Bp89OfZGGw==
Date: Tue, 12 May 2026 14:29:05 +0200
From: Christian Brauner <brauner@kernel.org>
To: David Francis <David.Francis@amd.com>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	Alexander.Deucher@amd.com, Christian.Koenig@amd.com, 
	Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
Subject: Re: [PATCH] fdinfo: Add fops flag to allow CAP_PERFMON to see fdinfo
Message-ID: <20260512-einlegen-ehedrama-26b2c2bb8918@brauner>
References: <20260504191429.1770840-1-David.Francis@amd.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260504191429.1770840-1-David.Francis@amd.com>

On Mon, May 04, 2026 at 03:14:29PM -0400, David Francis wrote:
> We want some GPU information to be publicly available to all
> processes for basic system-wide profiling (think GPU versions
> of top).
> 
> This information is available in fdinfo and not easily exposed
> by other interfaces.
> 
> Allow processes with CAP_PERFMON capability to
> - read /proc/<pid>/fd
> - follow symlinks in /proc/<pid>/fd, but only if that file has
> new file operations flag FOP_PERFMON_FDINFO
> - read /proc/<pid>/fdinfo
> - read /proc/<pid>/fdinfo/<fd>, but only if that file has
> FOP_PERFMON_FDINFO
> 
> Signed-off-by: David Francis <David.Francis@amd.com>
> Suggested-by: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c |  2 +-
>  fs/proc/base.c                          | 18 ++++++++++++++++
>  fs/proc/fd.c                            | 28 ++++++++++++++++++++++++-
>  include/linux/fs.h                      |  2 ++
>  4 files changed, 48 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> index 03814a23eb54..d62f8b400258 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> @@ -3022,7 +3022,7 @@ static const struct file_operations amdgpu_driver_kms_fops = {
>  #ifdef CONFIG_PROC_FS
>  	.show_fdinfo = drm_show_fdinfo,
>  #endif
> -	.fop_flags = FOP_UNSIGNED_OFFSET,
> +	.fop_flags = FOP_UNSIGNED_OFFSET | FOP_PERFMON_FDINFO,
>  };
>  
>  int amdgpu_file_to_fpriv(struct file *filp, struct amdgpu_fpriv **fpriv)
> diff --git a/fs/proc/base.c b/fs/proc/base.c
> index 6299878e3d97..83182ff6b96d 100644
> --- a/fs/proc/base.c
> +++ b/fs/proc/base.c
> @@ -86,6 +86,7 @@
>  #include <linux/user_namespace.h>
>  #include <linux/fs_parser.h>
>  #include <linux/fs_struct.h>
> +#include <linux/fdtable.h>
>  #include <linux/slab.h>
>  #include <linux/sched/autogroup.h>
>  #include <linux/sched/mm.h>
> @@ -716,6 +717,23 @@ static bool proc_fd_access_allowed(struct inode *inode)
>  	task = get_proc_task(inode);
>  	if (task) {
>  		allowed = ptrace_may_access(task, PTRACE_MODE_READ_FSCREDS);
> +		if (!allowed && capable(CAP_PERFMON)) {
> +			struct files_struct *files;
> +
> +			task_lock(task);
> +			files = task->files;
> +			if (files) {
> +				struct file *file;
> +
> +				spin_lock(&files->file_lock);
> +				file = files_lookup_fd_locked(files,
> +							      proc_fd(inode));
> +				allowed = file && file->f_op->fop_flags &
> +						  FOP_PERFMON_FDINFO;
> +				spin_unlock(&files->file_lock);
> +			}
> +			task_unlock(task);
> +		}

No, sorry, that's such a blatant layering violation tying together
capabilities restricted to a specific file operation marked via an FOP
flag. That is such a bad precedent to set. Let's not go there.

Also, if you don't have ptrace access rights to a process but then hold
a global capability as an additional escape hatch is such a twisted
security model.

You're trying to shoehorn gpu specific introspection into a generic
interface that has absolutely no business exempting them. Build your own
dedicated interface please and don't try forcing this into procfs in
this way, please.

Procfs has a very peculiar security model for very good reasons and
ptrace_may_access() is the canonical check - with enough special sauce
as it is. Let's not add opaque escape hatches for magic file
descriptors and open us up for more security suprises...

>  		put_task_struct(task);
>  	}
>  	return allowed;
> diff --git a/fs/proc/fd.c b/fs/proc/fd.c
> index 9eeccff49b2a..89c1a205148a 100644
> --- a/fs/proc/fd.c
> +++ b/fs/proc/fd.c
> @@ -86,12 +86,35 @@ static int proc_fdinfo_permission(struct mnt_idmap *idmap, struct inode *inode,
>  				  int mask)
>  {
>  	bool allowed = false;
> -	struct task_struct *task = get_proc_task(inode);
> +	struct task_struct *task;
>  
> +	task = get_proc_task(inode);
>  	if (!task)
>  		return -ESRCH;
>  
>  	allowed = ptrace_may_access(task, PTRACE_MODE_READ_FSCREDS);
> +
> +	if (!allowed && capable(CAP_PERFMON)) {
> +		struct files_struct *files;
> +
> +		if (S_ISDIR(inode->i_mode)) {
> +			allowed = true;
> +		} else {
> +			task_lock(task);
> +			files = task->files;
> +			if (files) {
> +				struct file *file;
> +
> +				spin_lock(&files->file_lock);
> +				file = files_lookup_fd_locked(files, proc_fd(inode));
> +				allowed = file && file->f_op->fop_flags &
> +						  FOP_PERFMON_FDINFO;
> +				spin_unlock(&files->file_lock);
> +			}
> +			task_unlock(task);
> +		}
> +	}
> +
>  	put_task_struct(task);
>  
>  	if (!allowed)
> @@ -338,6 +361,9 @@ int proc_fd_permission(struct mnt_idmap *idmap,
>  	if (rv == 0)
>  		return rv;
>  
> +	if (capable(CAP_PERFMON))
> +		return 0;
> +
>  	rcu_read_lock();
>  	p = pid_task(proc_pid(inode), PIDTYPE_PID);
>  	if (p && same_thread_group(p, current))
> diff --git a/include/linux/fs.h b/include/linux/fs.h
> index dd3b57cfadee..bc2826e1cc38 100644
> --- a/include/linux/fs.h
> +++ b/include/linux/fs.h
> @@ -2327,6 +2327,8 @@ struct file_operations {
>  #define FOP_ASYNC_LOCK		((__force fop_flags_t)(1 << 6))
>  /* File system supports uncached read/write buffered IO */
>  #define FOP_DONTCACHE		((__force fop_flags_t)(1 << 7))
> +/* fdinfo readable with CAP_SYS_PERFMON */
> +#define FOP_PERFMON_FDINFO	((__force fop_flags_t)(1 << 8))
>  
>  /* Wrap a directory iterator that needs exclusive inode access */
>  int wrap_directory_iterator(struct file *, struct dir_context *,
> -- 
> 2.34.1
> 
