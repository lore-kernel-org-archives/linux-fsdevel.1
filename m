Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3ED3D38E113;
	Thu,  2 Jul 2026 06:59:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782975586; cv=none; b=HddJ+4Ikat5VA8Gy9f4M4piVRzLYp217PJR8h6X3dv1gDY5W+un7eLs1j0kUTHMYsXhJteIG2GusWgq22hHHfIamYrrQwuztFqzYk53vJh8F5js3hoF+JY/ptgSZKf9Y/PsjseN9WN9/h0ARkMGH64zBDAqCCdGve4azpTGfi/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782975586; c=relaxed/simple;
	bh=018CCn7pWRsIxVjHxE6ozAxaKYlqI074/OA6xiK0OFk=;
	h=MIME-Version:Content-Type:Subject:From:To:Cc:In-Reply-To:
	 References:Date:Message-Id; b=WNnZSQ+GE9ZSPLg7rYP0Za1c/6U1EQ+1r3zu+Ht8lOWHojST8za4cWy/3wI4JZGBwWpvrJD2hbmCj3932cSTqt3OERklxGJ8EtGNiwoSHfV3jTeMq1CkzEHryZcYEz9VT5xQ87jNZV5WYNUil1T/cxL3sNi2cFVJUeWBZw6F/ew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JXhkAJFR; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JXhkAJFR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB5021F000E9;
	Thu,  2 Jul 2026 06:59:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782975584;
	bh=EZpMRxwFfau9M4Y3HLcLlprcqmSrU2bAWKh2dsyFm5k=;
	h=Subject:From:To:Cc:In-Reply-To:References:Date;
	b=JXhkAJFRvqiElHBwnRQJm+oz+lc9s8p/Z7fGFSo/vPxROywk+9Um55w8AZrxP/Xhe
	 8C5tS1t+724EfFY+4BW2Ny0Z+Fjs0zcWzZQkAerCmLkLWmL24kXGX/vkYC14sroXvR
	 dRrbWthEEVnY4Vw/wYhhswfDcastXw1Q+X0A4ablv1rRYiZwXOQynXXGTKbFD9cpV8
	 rcLQ829S9SWfa5jbAS0GgaIRlLGN4l2T67FAlYSg0hW5/oqxh6SRr7TEX6sna7zu4h
	 uiEKthN9Y6nJwEK4un74/lZiyFHj2iqs8Qwvnhl2NZH/BZYX0W3uhHx6ds9tBb0Ref
	 LMqpB/BujYY6A==
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] audit: add FSOPEN record to log filesystem name
From: Christian Brauner <brauner@kernel.org>
To: Ricardo Robaina <rrobaina@redhat.com>
Cc: audit@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
 linux-kernel@vger.kernel.org, paul@paul-moore.com, eparis@redhat.com, 
 viro@zeniv.linux.org.uk, brauner@kernel.org, jack@suse.cz
In-Reply-To: <20260701132410.711205-1-rrobaina@redhat.com>
References: <20260701132410.711205-1-rrobaina@redhat.com>
Date: Thu, 02 Jul 2026 08:59:38 +0200
Message-Id: <20260702-edelherzig-hammer-beenden-08e75c154e46@brauner>
X-Mailer: b4 0.16-dev-4217c
X-Developer-Signature: v=1; a=openpgp-sha256; l=1343; i=brauner@kernel.org;
 h=from:subject:message-id; bh=018CCn7pWRsIxVjHxE6ozAxaKYlqI074/OA6xiK0OFk=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWS58cTNMTMwMFnw/MjciFsBsw0O/lEMiTmiFBl+cPPCG
 4yWctarOkpZGMS4GGTFFFkc2k3C5ZbzVGw2ytSAmcPKBDKEgYtTACayfRsjQ9/6Wa6cHQ8E/8Xv
 DHe1KLZziXdJOTjbVOxCTsOkjCojOYZfTFvdbjOlbRWd/Msg45H5Q7ltndzbA1qOxLUlCTKuMVf
 kBgA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

> Modern mount tools (util-linux >= 2.39.1) use the new mount API
> (fsopen, fsconfig, fsmount, move_mount) instead of the legacy mount(2)
> syscall. The generic SYSCALL audit record logs the fsopen syscall but
> does not capture the filesystem name string, creating an audit gap for
> filesystem mount operations.
> 
> Add an FSOPEN auxiliary record that logs the dereferenced filesystem
> name string passed to fsopen(2).
> 
>   type=SYSCALL ... : arch=x86_64 syscall=fsopen ... a1=FSOPEN_CLOEXEC
>   type=FSOPEN  ... : fs_name="tmpfs"
> 
> Link: https://github.com/linux-audit/audit-kernel/issues/152
> Signed-off-by: Ricardo Robaina <rrobaina@redhat.com>
>
> diff --git a/fs/fsopen.c b/fs/fsopen.c
> index ae19e5136598..8b07f9d42be2 100644
> --- a/fs/fsopen.c
> +++ b/fs/fsopen.c
> @@ -15,6 +15,7 @@
>  #include <linux/namei.h>
>  #include <linux/file.h>
>  #include <uapi/linux/mount.h>
> +#include <linux/audit.h>
>  #include "internal.h"
>  #include "mount.h"
>  
> @@ -150,6 +151,8 @@ SYSCALL_DEFINE2(fsopen, const char __user *, _fs_name, unsigned int, flags)
>  	if (ret < 0)
>  		goto err_fc;
>  
> +	audit_log_fsopen(fs_name);

Right above:

	fs_type = get_fs_type(fs_name);
	kfree(fs_name);
	if (!fs_type)
		return -ENODEV;

So that's a UAF.

-- 
Christian Brauner <brauner@kernel.org>
