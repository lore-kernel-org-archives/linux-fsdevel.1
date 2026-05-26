Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E95F3BE17E
	for <linux-fsdevel@vger.kernel.org>; Tue, 26 May 2026 07:14:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779779655; cv=none; b=G/KIHYO4Dfdxc1lLCCAHi0CZfjqjc8S8uCvVVQT14qhg93RET5iAt7yOWi2Rp68PsHATfHdygajxsxQtiAP4xm+9myZj7paYbgS99O1ZbQcsMuZ9IDu/NZkrfk13sD7WhdNXpDadG/GvKmn+I7u865rtZWg8BfoC89u8q6rPHAo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779779655; c=relaxed/simple;
	bh=66qizlrtCwOvYCskc9Z4D9GEOxk4juRD1CgGxs7OKeI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=m0pFvwqpKhDuemcQmRnziIcJlUuI0bLhVMIJMDQYRfHn/7tL8Fscu98ljHuK9PyQythnVK3bOu6L/UfNwnvxxibJgegXaXmh2N4vk+Y3ITyjQr0vgOkZolI9h6Ls/DwC563FQDCJZQtnaG6KX3VaDIbaomQD+N8JX9uuTK/NucY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EE+3QAot; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EE+3QAot"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-49048e043e5so26634995e9.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 26 May 2026 00:14:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779779652; x=1780384452; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=dj+eE+RlTPGlS54IS4RQITRV1ozUmgsawvGomWzpqKc=;
        b=EE+3QAotCYI9UYfOJl2vpzmReX9EcSclOxkBFtklY4GiEgvV38DuvZ7FNTfNKybyLP
         2Y2H9UdWn1coLehfXcMyPHqSii8afHze9LYFA55tJ+cPVTTMGoyEX6GyPhPVIuj6KwQM
         DRGg+1TxiX1EnG7UuEFcuhVsZxWutUAIDhEM2VXnQRCXYoGbIGno5Xyqo2zciT5mCDS7
         5xwXVrGysxQ/M6SN6gQLBPeeR+rKgDTtV2oIZD9r03EVwSXCRxFOQ6/rAOa+c9hCmjhn
         6HhmKoZf66Ac4KPSxn0hFh+nFnM5XwpeXHaHq6frCFaMBtmZ9PtIxm62izAYu6DKr6ob
         zk0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779779652; x=1780384452;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dj+eE+RlTPGlS54IS4RQITRV1ozUmgsawvGomWzpqKc=;
        b=D5LdhSfGWlTYnJdy0abYYaDw5yOsZTaOZ5kySiWltn07j4L0K74pWUulmRRHBDaaaF
         qyKqz2cnbLmen8cawMMmxBKXgz9L7xP25etCKoegMzFzDxG2oVRfc3MGa/cJpB+TV/LQ
         s1ziKtJ+USQtDdpjKFhNa4A6c72sik1/XtOGnfgxSLdEw7hY9S8+xlTZD1xubaW8Y2ag
         eDcKGQ4MrRBVWgITqCQODGXBdgr5KjXfsBWzzTvwtadSEW0G2MO3ayTE3C9IDUnexFe6
         bgURhqGw42pZiXfsEqQ8PVwzKWxluAlzExLqXFRaPK3LNzercduzIB0quy4nGy0Bbg7n
         YEsQ==
X-Forwarded-Encrypted: i=1; AFNElJ/FPi2NhIk1MHEMnPpS7f3lad5tzd9ERozR6o22j6VMKdC2mYFBKeiGzxH4YqXxT5I95mKYne9a0JZEU+dY@vger.kernel.org
X-Gm-Message-State: AOJu0YymmZOt1cn6bsfmn9f9HXZ9zg1170hLmbjt/usPKocn4LwA+WEi
	XPCB/ZxpBig/PEhRrYGZODY0CDwdp50ewzunpseqPJnDUy7Til2mAaqZt8xMdw==
X-Gm-Gg: Acq92OFMYzJGezh9EqNfbk0g7Dssmj9naIfX1Qgpzq30cibGNfniZsEuT4zpq+9o3WE
	BVKPGDOWn0URPnMpr5HdIqbSZZzqWPpGx0glpBgKBllJKD9tWOVDeSn2G44SYV9Vfas01M3SwlE
	rocoXooFiENKJjFieX9SpaFb/lsNMRCHfj0XRpjcdIX3be2Z77oGPtuvv65o/dLNhLl+P64mlhW
	Dna3hKuIv59ifuI7QOC6sUVgRO0eyFbggWMhM4hPHtMS6s+wmzjZtTpXr5MrlnKIP1SCZKT76xz
	YVs7bsZH6T1LLgtfmWk8Jl8jYOz3gRGUQ5DrmgcbOz3sDLxDZQBbNQkt48+S7RW7BTVvQ5z5qe7
	gHxPs/LLry//Vz+at3uqutuf0DIjqfDJT/MtyUB9VqrQQklGDZKEsr02Jy8YnnUJ9nRtaKLjUm9
	ONXOL5uTlnH1ZPfNE0zdnrYyuHg/1Ya1fXbfpjWVk6Hi2SoDEPyuGNiVGw8wDSwSa+PmF4ghs=
X-Received: by 2002:a05:600c:4591:b0:490:6869:46c6 with SMTP id 5b1f17b1804b1-490686947a8mr90576555e9.31.1779779652251;
        Tue, 26 May 2026 00:14:12 -0700 (PDT)
Received: from f (cst-prg-92-135.cust.vodafone.cz. [46.135.92.135])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490418b27b5sm104970705e9.11.2026.05.26.00.14.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 May 2026 00:14:11 -0700 (PDT)
Date: Tue, 26 May 2026 09:13:28 +0200
From: Mateusz Guzik <mjguzik@gmail.com>
To: NeilBrown <neil@brown.name>
Cc: Christian Brauner <brauner@kernel.org>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, Chuck Lever <chuck.lever@oracle.com>, 
	Jeff Layton <jlayton@kernel.org>, Benjamin Coddington <bcodding@redhat.com>, 
	linux-nfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] VFS: fix possible failure to unlock in
 nfsd4_create_file()
Message-ID: <36bvv2anew3cegsd374uzwdgue2txpgnzo2357ye5pldqi4by6@lafavyjgevqo>
References: <177969022571.3379282.16448744624428323496@noble.neil.brown.name>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <177969022571.3379282.16448744624428323496@noble.neil.brown.name>

On Mon, May 25, 2026 at 04:23:45PM +1000, NeilBrown wrote:
> 
> atomic_create() in fs/namei.c drops the reference to the dentry
> when it returns an error.
> This behaviour was imported into dentry_create() so that it
> will drop the reference if an error is returned from atomic_create(),
> though not if vfs_create() returns an error (in the case where
> ->atomic_create is not supported).
> 
> The caller - nfsd4_create_file() - is made aware of this by checking
> path->dentry, which will either be a counted reference to a dentry, or
> an error pointer.
> 
> However the change to use start_creating()/end_creating() (which landed
> shortly before the dentry_create() change landed, though was likely
> developed around the same time) means that nfsd4_create_file() *needs* a
> valid dentry so that it can unlock the parent.
> 
> The net result is that if NFSD exports a filesystem which uses
> ->atomic_create, and if a call to ->atomic_create returns an error, then
> nfsd4_create_file() will pass an error pointer to end_creating()
> and the parent will not be unlocked.
> 
> Fix this by changing dentry_create() to make sure path->dentry is always
> a valid dentry, never an error-pointer.  The actual error is already
> returned a different way.
> 
[..]
> +		/* atomic_open will dput(dentry) on error */
> +		dget(orig_dentry);
>  		dentry = atomic_open(path, dentry, file, flags, mode);
>  		error = PTR_ERR_OR_ZERO(dentry);
>  
> +		if (IS_ERR(dentry))
> +			/* keep the original */
> +			dentry = orig_dentry;
> +		else
> +			/* Drop the extra reference */
> +			dput(orig_dentry);
> +

atomic_open() is a static func with only 2 callers. perhaps it would be
better to change its semantics instead?

I'm asking because the vfs layer is very slow single-threaded and this
here just adds even more slowdown due to avoidable 2 rmw atomics.

Granted the affected routine is only used by overlayfs and nfs, but even
then this should not be necessary.
