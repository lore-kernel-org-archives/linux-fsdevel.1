Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com [209.85.219.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C783363C5A
	for <linux-fsdevel@vger.kernel.org>; Wed, 27 May 2026 03:00:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779850860; cv=none; b=uZfo6avCXAaVp1yLR2GnR2GtHzsipzHyDu4RvHofOup+2cEUsOx97kv2ah9+G7xBTj/Go1A9IXQzq9UyjXSWJZ4v6d/Gtt5idQtRsD0w2Ee8tjd11I2N5iGmH2WdgOqoM/LZwRQ9XqV09SLXwx4KMuWjVtypkGQUW+E2nob5o4U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779850860; c=relaxed/simple;
	bh=l24Cx1MrKrvp4Q2cUKmT1CDQC1RwyjfAflDdCsjh3ng=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VZV97ZQPifMUC6VDbHBKwg8mE8+srS79wQLXklb6mhh2t6z2YUwGpKyIxfB+1ZIYwjyVeEM9PiXaKUOuuXZvvuUBOQOBfPeUoUlIjH9bHThxGTVJbZqKeVq0eNysyBV+/odOdnTRAaN299eQZ3uLoO5tgSlsEzAEHP19x67AX98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=otPOjawa; arc=none smtp.client-ip=209.85.219.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="otPOjawa"
Received: by mail-qv1-f47.google.com with SMTP id 6a1803df08f44-8b5de17382cso87353446d6.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 26 May 2026 20:00:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779850858; x=1780455658; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=LW74ifQIEMw9K0LJrVq6jLhT79y6ZRMrtmCmy57465k=;
        b=otPOjawas0BUAfr7T7mWO/WO2cE9MqQwXaLT1vnDh7uBqVDWlQ2LzgkXovUMs3I5xK
         hI3emTeseBOhS4+I7/IBi8+P4GZ0RxFZKb/a5WvujLn5k6v/34AmyenTjzCeCdJbg32T
         mlHQ0xigGqGFb8VGAkB6pHqB0l7XbFEqw+ETuaIqQHKYCvP6DXRofuaFs4/aeANIvPDH
         de33rYv4z2KOJcLwuM6+TeylcJmBEaD5T08oFieNjlNn494zPrLIe8rGNP/N6tPOtPG5
         2WE2mrnc6zEJy8CYtxH4udIJGEDa4kVLTsM7U9McNlfe95D/MytXxo5sO4VPh+4uVCiD
         eLEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779850858; x=1780455658;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LW74ifQIEMw9K0LJrVq6jLhT79y6ZRMrtmCmy57465k=;
        b=garoPi6pPHHg6MUgAK/6yqj7yU8CZrV01oBOnHNISNle/O3tglKEuNGkEomAjP4hmL
         uRUMthw1Z5JfYDjXYZjKzmWwyr9kwmiV0RekKq23zsUW0KX/C7nGyKw7JWKlqqbA7Zpy
         u0MpZC32Xmy4xg13shGQzrSLUQFbqZ+acnv0MXJqwNw9dVdDK2mZOAI+lvvmZMToh1an
         LsDaZEZBnVgZfptg8kub6C1w2odmSNS2EuB04ZJFGM+iBWNTpvrb8EI7UJLCQBaWW758
         dijsRG0l44OBalDdM8+2lkJuBWrogGgxxhVep4mQwckuxamlN1e2wi85nIXlOm1W+R0y
         rvkg==
X-Forwarded-Encrypted: i=1; AFNElJ8Z85gt+JFsqiu05qCUi16mknTVs0sLGXK8Z4I9P6Yc/V6Xwm+V+CXrGki3I5jFvBiJp/WxfIyr+s332WOI@vger.kernel.org
X-Gm-Message-State: AOJu0YxnB59vLjwhx6v2bkC7+OwuuoWdcZzIyxEHYyYvBYb99ZRNZRy+
	X6X3MxATsYLJmU9QtahNOmWZJKXnGVqf683eSHe10OEB+R9gjDp6TJH0
X-Gm-Gg: Acq92OHp+LH386NFqXs0Bc0bAAFsUsH+h1v8MWZIgzD6e4LycyqUCCa3WKERgcwiK1D
	m5vwy2YOpZwwm68fh9YdkXrV0pWv1QDukrHMwwe+xiubqxswZgVqfUyUj2l2tVooo/0wmhZk3pp
	r83y+TYWzfJ+8+9qsAtkz3sMG2FaUiTA01yh1GWhG/dh+W8IgxtgWF5PE0XaKyT9vZLSQYwVK+G
	N3DwNSkh5KgDOpRs2fuUtV0ziSnW2XwFX9y0pe9iXMJI7tEvwBgRkyr3Xt5lNJBtMPHkRYMtOnb
	7613/o/NtPd53EW/1vgXOhm9SfO3JMYSir1Lt+fATcbk+Iz93lz4zeIeUp0HU11TyY2A+TnksgG
	U0YfRMuHQPVV5vcLkXzjJnC+iPMDEhpt6/2La2W2/e0X06BOS/b1JUO6uKfT5kdtV5DfWWrty8q
	ldo2MgKHY4BCE6+EyRLTvOtcq6bnINHD83sKm5PrdL5ksGin66D2SV1Q2ch1TYOk3yAVGGWBLpx
	YEzA2I0FDtvQu2R3GYtYA==
X-Received: by 2002:a05:6214:5093:b0:8a0:3bd8:5950 with SMTP id 6a1803df08f44-8cc7b5c0bb4mr338124896d6.23.1779850858174;
        Tue, 26 May 2026 20:00:58 -0700 (PDT)
Received: from fedora ([172.245.82.59])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8cc81302a98sm153788216d6.33.2026.05.26.20.00.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 May 2026 20:00:57 -0700 (PDT)
Date: Tue, 26 May 2026 22:00:49 -0500
From: Ming Lei <tom.leiming@gmail.com>
To: Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc: Jens Axboe <axboe@kernel.dk>, Bart Van Assche <bvanassche@acm.org>,
	Christoph Hellwig <hch@lst.de>, Damien Le Moal <dlemoal@kernel.org>,
	linux-block <linux-block@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	linux-btrfs@vger.kernel.org, David Sterba <dsterba@suse.com>,
	linux-fsdevel@vger.kernel.org,
	Christian Brauner <brauner@kernel.org>
Subject: Re: [PATCH v3] loop: Fix NULL pointer dereference in lo_rw_aio()
Message-ID: <ahZeYQ0cLE1i8TGs@fedora>
References: <ag0lS_CbKO9R5CV8@fedora>
 <94076bc9-2c09-4bb6-8468-b6b8af419cb9@I-love.SAKURA.ne.jp>
 <ag1nfIFcykmQHbkk@fedora>
 <1ab8c579-eb76-4227-8a72-6ec819135219@I-love.SAKURA.ne.jp>
 <ag1223nAa0wZ8ALC@fedora>
 <fda8abc8-6aa2-463b-bf72-865f6b838034@I-love.SAKURA.ne.jp>
 <ahRocb0Vs_m6RF_O@fedora>
 <1a9f53d4-6f48-4df8-a3d8-2b0e442a163a@I-love.SAKURA.ne.jp>
 <ahZGxoI6oHQ_vSrx@fedora>
 <d1b5a737-f0e3-4927-b762-430b37fbb2f9@I-love.SAKURA.ne.jp>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d1b5a737-f0e3-4927-b762-430b37fbb2f9@I-love.SAKURA.ne.jp>

On Wed, May 27, 2026 at 10:35:56AM +0900, Tetsuo Handa wrote:
> On 2026/05/27 10:20, Ming Lei wrote:
> >> Of course we should try to figure out the root cause first, but how can we do?
> > 
> > Definitely unexpected write IO(after umount & loop closed) from btrfs is more serious,
> > which may cause data loss, so CC btrfs list and maintainer.
> 
> Why do you assume that the culprit is btrfs?
> 
> https://syzkaller.appspot.com/bug?extid=bc273027d5643e48e5b3 indicated that
> this similar race is also happening with jfs.

I just didn't see the above report on jfs.

It doesn't change anything, the same question still stands: unexpected write IO is issued
or crosses umount & last closing of loop disk.



Thanks,
Ming
