Received: from mail.mainlining.org (mail.mainlining.org [5.75.144.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 489E429B795
	for <linux-fsdevel@vger.kernel.org>; Sat, 26 Sep 2026 14:42:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=5.75.144.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790433757; cv=none; b=TVKGyYeEK5CYDBVCgfdwxxlJQh3mblzREhz+VuL2xspWCzHGowDt2MDs2irhXYYfHW/jJv+DWM/E6CX6F2n+V2ad1yucxa5iUf+1g6fPRh9emZLWEHXdjm3b5zs6qfNiI2izNaFUKT3dlQipkG+kSsaTx0pQINm4F4Bg0EHYWow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790433757; c=relaxed/simple;
	bh=b5F4UzaeOjViWxEXne2XaAK85DfVFQQrdclXJsqbruw=;
	h=Date:From:To:CC:Subject:In-Reply-To:Message-ID:MIME-Version:
	 Content-Type; b=NlD92b9u437ptxMVJQ99t5x/nzXWP+1qLvMe0QSA/rESNcdTmEX7OJUSDRE97bVWi3zXVnn5hEjs90rQpgU3NgYOxgJnp2CmVuwYeRKukkO+TrrcxLU8Y2+2Jn60iHLDScxiVGxhmJwQNpYNPSFi4HvG8oSC0LzJgMlNNMapaeo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mainlining.org; spf=pass smtp.mailfrom=mainlining.org; dkim=pass (2048-bit key) header.d=mainlining.org header.i=@mainlining.org header.b=s98sAEX2; dkim=permerror (0-bit key) header.d=mainlining.org header.i=@mainlining.org header.b=ynMkDznq; arc=none smtp.client-ip=5.75.144.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mainlining.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mainlining.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mainlining.org header.i=@mainlining.org header.b="s98sAEX2";
	dkim=permerror (0-bit key) header.d=mainlining.org header.i=@mainlining.org header.b="ynMkDznq"
DKIM-Signature: v=1; a=rsa-sha256; s=202507r; d=mainlining.org; c=relaxed/relaxed;
	h=Message-ID:Subject:To:From:Date; t=1790433752; bh=9BEpsRLreHlSfmtJsdEsR+M
	nhgucNoXGsWcOiMR82I4=; b=s98sAEX2rwZCA9p0lzy/eVeATvtfK0wgNjQjYHM8l5bw2HzCVj
	kbFJ18fdtjBTbkL0ivlCNRIMfASYd7r3zzBmwmaBHtyMggHsoqEFS7fMZWP2f9PBeOCrYdiV/yL
	sOPwtl5QIdBRjsW3F7zaHyRv+QDpLmZNx8sI2ieFnjeALEAXGeT3ciD+REUg4OZ7QqAqmRydN7/
	ieRC9sqM0b1gqOd0jtXngudV19hV5zPIoOR0515w54fYbLIiIuOXwYO9Ene6Vw9uFh62Q92AcSq
	y4IxVv9CnTNAnHIQSvr69VfFzH806in0u0sAck2XUouNcK1o68vSsKX9UVSLRYTwlNA==;
DKIM-Signature: v=1; a=ed25519-sha256; s=202507e; d=mainlining.org; c=relaxed/relaxed;
	h=Message-ID:Subject:To:From:Date; t=1790433752; bh=9BEpsRLreHlSfmtJsdEsR+M
	nhgucNoXGsWcOiMR82I4=; b=ynMkDznqdtOUgSjJA/w5/PLkzY8D3Ullcb51oEKyTdveugP0ax
	d+BjTzD4wPfFgM0aboL3SYHNqfWo1vWBUwCg==;
Date: Sat, 26 Sep 2026 15:42:33 +0100
From: Bradley Morgan <brads@mainlining.org>
To: brauner@kernel.org
CC: jack@suse.cz, jannh@google.com, linux-fsdevel@vger.kernel.org,
 torvalds@linux-foundation.org, viro@zeniv.linux.org.uk
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_07/10=5D_fs=3A_put_the_old_fs=5Fstru?=
 =?US-ASCII?Q?ct_before_the_old_namespaces_in_unshare=28=29?=
In-Reply-To: <20260926-work-mount-fixes-2-v1-7-f357abf3d17b@kernel.org>
Message-ID: <3049586F-1DAE-41C1-BF4F-A29F225A9E4F@mainlining.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 8bit

On 26 September 2026 14:44:30 BST, Christian Brauner <brauner@kernel.org>
wrote:
>unshare(CLONE_NEWNS) always copies the fs_struct and copy_mnt_ns()
>points root and pwd of that copy into the new mount namespace. The old
>fs_struct pins the old root and pwd until ksys_unshare() frees it at the
>end and switch_task_namespaces() will already put the old mount
>namespace before.
>
>This causes pointless work in user namespaces because the copied mounts
>are locked and stay connected. Switch and free the fs_struct before
>switching the namespaces. The old root and pwd are wasted while their
>mount namespace is still alive which also keeps both puts on the
>mntput() fast path.
>
>setns() already does this right as it updates root and pwd before the
>namespaces are switched.
>

I can't see a issue with this, unless I'm dumb and crazy

Reviewed-by: Bradley Morgan <brads@mainlining.org>




>Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
>---
> kernel/fork.c | 9 ++++++---
> 1 file changed, 6 insertions(+), 3 deletions(-)
>
>diff --git a/kernel/fork.c b/kernel/fork.c
>index 416758c8a3d4..da48168c504f 100644
>--- a/kernel/fork.c
>+++ b/kernel/fork.c
>@@ -3312,14 +3312,17 @@ int ksys_unshare(unsigned long unshare_flags)
> 			shm_init_task(current);
> 		}
> 
>+		if (new_fs) {
>+			new_fs = switch_fs_struct(new_fs);
>+			if (new_fs)
>+			

Ack.
	free_fs_struct(no_free_ptr(new_fs));
>+		}
>+
> 		if (new_nsproxy) {
> 			switch_task_namespaces(current, new_nsproxy);
> 			new_nsproxy = NULL;
> 		}
> 
>-		if (new_fs)
>-			new_fs = switch_fs_struct(new_fs);
>-

Deserved.

> 		if (new_fd) {
> 			guard(task_lock)(current);
> 			swap(current->files, new_fd);
>
>

--- Thanks!
"I'm not a very positive person" - Linus torvalds
