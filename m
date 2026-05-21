Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 795C1346FA7
	for <linux-fsdevel@vger.kernel.org>; Thu, 21 May 2026 09:09:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779354556; cv=none; b=Na/V+VbXcVgo8mzMHD5YJwmgrz3Bp9V1OYYr45hxNOohlE0O9NTsfmjrKZRWoXcoeb1Jsu/JIU0OSrBraQ515YgFToP1sdi3JvDA+LOhodrFtc/+CA4222KMAKPAZISczl/Ah5fZc8Aa5fQrqq0lZELHxRO/bfgT2m/UleZQybI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779354556; c=relaxed/simple;
	bh=62AQbruIL8xoYE0iLxKmGGOuXzkPv/xXfeMgG0rWsAU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cU+UgRWGkT9WoWukevkvkIDpdv2ZenlrFUi+Dc42yKcPI0iqrMuI/No1H3zwjo1awyjy5/sY+j/jopCaYaPqvDgezejvmWImNv//QsFLoHGxyz5hQ1W+8lKPxyBnPpZACcCeuLqjH9pjjSzKIKfoj+4ApsVmhTD4ph4/kTwg/+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=X8O9Gj8n; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X8O9Gj8n"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4903974854dso3220785e9.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 21 May 2026 02:09:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779354553; x=1779959353; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=b8kZ2i7zbAXV5yShgKzVk4H5++8WU3pOXXmVGQ1GdXg=;
        b=X8O9Gj8nNT5ODFEGeuEq1zxVDPq67jnvc/FK6wiwPBXDQxmk7XdsR+cp9vxO9zp0CO
         UCRLYlsDmyNQdPTNfyWQBrYO2DfCT/JjKFgz7gYlFLM8d6ZAbIDO9Umq03/sXc0ISqvk
         plLKa711B32AOiiVYFYsGNJkxNHR/lD3lw53vlRgNkjuTPLq5n1yFS5YIMZXj8HGttk/
         QYEOAdQpCAic15d/h6Hcod69WW9rkTgHUNFximhZe1Oqk+6ACqSLDFjEYQlHTyYZeYzv
         f/wvMV4wENJPEIs8DN+CqbdbkxLdsySsK8q/Iq17NJUpLyBwiIJW0wmSb4XGDE/RQcCW
         HnzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779354553; x=1779959353;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=b8kZ2i7zbAXV5yShgKzVk4H5++8WU3pOXXmVGQ1GdXg=;
        b=H4vBEaXfg8Ix82wJ81y/Q0Au4ptPnH0EnTE3zkoPxFxGH3UfEvLIlxb4sPstd5Qwr2
         JFKseIXQfMNJF4HyR3zzco/BEGP4zOqO2qawyWXcmBRGmc5hOk2w0cSu4qbCwXchSL1l
         uHg9+KNcyS84RWxuxQYth19SXLziLMPluMHEdD73YKzMj/BJf8qaJfT+5tXTBY2vmJXO
         RDP7qXJuT/w2BT70yhEMBMI0XJA19ZLMLbznFjoInPTqvQOVJANZOs4QCYmnQLeuaZ4T
         enStRJt/iVwBYa4ZcKJLdxwImIFFmyL4DN504DXQ94RpdKb9a43FNE+kQ66VpsDu3uU5
         /dtQ==
X-Forwarded-Encrypted: i=1; AFNElJ+QGQKUWBCgS3HCcpxUd4fmLqQKycPRxZXQAlLcXrNeOtSBniBY2XNeleAwZ3FhFJnTPLVuL4Ws11UfU+4g@vger.kernel.org
X-Gm-Message-State: AOJu0YwyxB46JW0SW8nbRRV5O+ycKpgtvsmGAMpLcpLqMplw5/IUJ5kV
	ScGopHegZTV5402dSwqMm3w2d/EDVxjoiufQ1+5e3R9PKrNX8XV+1ot0
X-Gm-Gg: Acq92OFQsqUYsXcF9erjuF20LH2CWDgWh25l5rVB4JcdfgSvKYBA/D8/DprB9aYotY5
	VcBPSSHSFOIJGOPAXvrpSg5aE3SNJpHoeaca13v4C0CeGhJa/ewmwqEXxjv1ROV+wLhzmhLwr8m
	7EeAOSc/8A9CtUgWk4H0vU/WK2qVoVtYi/et12k/VjzgJmurflXDl+HNDL28Bwi+nTL4wZfnTvK
	Cio7Bo1fjr4qo76JviF9OEKfPBYCaLBen9qVQRGCM/pAJm8y0mWj9WkfhRpy9E8HAP8q4sK/wnp
	Rhb1DZ0ZWwzXf+RpTsIAIM8m9ivh7NoTiXnLDseQwG6yXEHTKPzuQu/r3nbTv09DdO3fcZ0KD6K
	DVm2kHK6thGVSCZmHB3YMtPPP3e65vrumViyHzK4lpXtw21+EV4sK/mmpPFOk//UINa9Uf9HFxX
	lIvQ5/Y4ShzK5zas73oYdjQkh5xp+4zXkIKOe3yxfHfrCNrhtx8x7qi4aIpxa9RJ3ZqUlll+s=
X-Received: by 2002:a05:600c:6990:b0:48a:7aad:4425 with SMTP id 5b1f17b1804b1-49036034012mr30158435e9.3.1779354552529;
        Thu, 21 May 2026 02:09:12 -0700 (PDT)
Received: from f (cst-prg-92-135.cust.vodafone.cz. [46.135.92.135])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45eaa756d61sm1354219f8f.0.2026.05.21.02.09.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 May 2026 02:09:11 -0700 (PDT)
Date: Thu, 21 May 2026 11:09:02 +0200
From: Mateusz Guzik <mjguzik@gmail.com>
To: Bert Karwatzki <spasswolf@web.de>, 
	Christian Brauner <brauner@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-next@vger.kernel.org, 
	linux-rt-devel@lists.linux.dev, linux-fsdevel@vger.kernel.org, adobriyan@gmail.com, jack@suse.cz, 
	viro@zeniv.linux.org.uk, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
	Thomas Gleixner <tglx@linutronix.de>
Subject: Re: context switch within RCU read-side critical section in
 next-20260518+ with PREEMPT_RT
Message-ID: <s7cu3dpioidx6mepmai6eyj2pxjs4skbw7v534zbzs6g2fwcis@cvokidcxy3xa>
References: <20260520225245.2962-1-spasswolf@web.de>
 <fnrz73n5jojl2wlbgrsjdtu5zuwykwbcjzznaijbquuovpoand@i6ihdqn7a6zv>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <fnrz73n5jojl2wlbgrsjdtu5zuwykwbcjzznaijbquuovpoand@i6ihdqn7a6zv>

On Thu, May 21, 2026 at 10:53:03AM +0200, Mateusz Guzik wrote:
> Christian, can you fold this in please.
> 
> diff --git a/fs/filesystems.c b/fs/filesystems.c
> index 771fc31a69b8..8f17c0abbc95 100644
> --- a/fs/filesystems.c
> +++ b/fs/filesystems.c
> @@ -289,6 +289,7 @@ static __cold noinline int regen_filesystems_string(void)
>          * Did someone beat us to it?
>          */
>         if (old && old->gen == file_systems_gen) {
> +               spin_unlock(&file_systems_lock);
>                 kfree(new);
>                 return 0;
>         }
> @@ -297,6 +298,7 @@ static __cold noinline int regen_filesystems_string(void)
>          * Did the list change in the meantime?
>          */
>         if (gen != file_systems_gen) {
> +               spin_unlock(&file_systems_lock);
>                 kfree(new);
>                 goto retry;
>         }
> 
> 

Even better, I got the above fixup + some polish listed below: 
- removed an extra space in newlen calculation
- the WARN_ON_ONCE case needs to free 'new', not 'old'
- there is no READ_ONCE anymore in filesystems_proc_show()

goes into the "fs: cache the string generated by reading /proc/filesystems"
commit.

diff --git a/fs/filesystems.c b/fs/filesystems.c
index 771fc31a69b8..712316a1e3e0 100644
--- a/fs/filesystems.c
+++ b/fs/filesystems.c
@@ -269,7 +269,7 @@ static __cold noinline int regen_filesystems_string(void)
 	hlist_for_each_entry_rcu(p, &file_systems, list) {
 		if (!(p->fs_flags & FS_REQUIRES_DEV))
 			newlen += strlen("nodev");
-		newlen += strlen("\t") + strlen(p->name) +  strlen("\n");
+		newlen += strlen("\t") + strlen(p->name) + strlen("\n");
 	}
 	spin_unlock(&file_systems_lock);
 
@@ -289,6 +289,7 @@ static __cold noinline int regen_filesystems_string(void)
 	 * Did someone beat us to it?
 	 */
 	if (old && old->gen == file_systems_gen) {
+		spin_unlock(&file_systems_lock);
 		kfree(new);
 		return 0;
 	}
@@ -297,6 +298,7 @@ static __cold noinline int regen_filesystems_string(void)
 	 * Did the list change in the meantime?
 	 */
 	if (gen != file_systems_gen) {
+		spin_unlock(&file_systems_lock);
 		kfree(new);
 		goto retry;
 	}
@@ -321,13 +323,12 @@ static __cold noinline int regen_filesystems_string(void)
 		 * generation above and messes it up.
 		 */
 		spin_unlock(&file_systems_lock);
-		if (old)
-			kfree_rcu(old, rcu);
+		kfree(new);
 		return -EINVAL;
 	}
 
 	/*
-	 * Paired with consume fence in READ_ONCE() in filesystems_proc_show()
+	 * Paired with consume fence in rcu_dereference() in filesystems_proc_show()
 	 */
 	smp_store_release(&file_systems_string, new);
 	spin_unlock(&file_systems_lock);


