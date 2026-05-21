Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 994F21FC7C5
	for <linux-fsdevel@vger.kernel.org>; Thu, 21 May 2026 07:09:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779347401; cv=none; b=XVZpkcg13T4ZvdekagildtCP5K9S3imOLR3sUN4JZ5njA+M82Xo1mdD5AC4S48n3OzmoNnguxorzwmcEP0smUmf/VjhfdBlptWI+dFplQxpgpZo/iHZ/A4g/MlgpSiNA+/3l3ehztDnieQ7JMEc0LSiix/J1xyrOAL5rQ+yq6gc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779347401; c=relaxed/simple;
	bh=Zogt1jCIr4qEoO9km/Mm+1+Fn6o+4tqZwyDn4ARLzd0=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=dq2HW2La4Bgj11GOOoXT9tEc+HJoE5RYtkBouIA0dbx97najOXLjjnM32HnK5QwJ1t1zYvg2GDs7V8hwsyjtST2zOXZsk03yQX4u78RizRqz43jPQQRB21Upjo+/nf0NQmauIB7mpZS15kkp5CnQl4OwTaIIct9WbEczylse6eM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=odRON+2I; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="odRON+2I"
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-43fe608cb92so3545423f8f.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 21 May 2026 00:09:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779347398; x=1779952198; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=q3/xpxUO6thsRAszOIsZ6+lXY5oUjTLCyWKPqe1vTLg=;
        b=odRON+2IYVLpUCef8LWId8feSvulapM4W3Nn3xS4LhQFbfv7JXXsVw4lYlSRjXMQVa
         +n0H+AIaDQd3Tb7U2xIhxpSTG1qGeOP7sEKZY4Fc9OehNFHMj+vDhu0aIMSFIJxLqvtv
         3HzRQ/UmP2cOVLiTpT2RkFaVLaSGwRcs6bOjfPsc1FpPhf70+iicm1v+GLzd0BxphueS
         OTFiUHPMuZKJ+RAwH3QgH0r30F4HF7q8ed/JE8FdsEiTPwnxniHitIC/6NzaFWNjhXPr
         oyXYuNWkZz7VUr3GdyJCPjU3HjpESRwmtCgKcLhmz7LwenAdUsnAptikD2eKwEH5RpMy
         9FtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779347398; x=1779952198;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=q3/xpxUO6thsRAszOIsZ6+lXY5oUjTLCyWKPqe1vTLg=;
        b=QKeM72p8IJ+KJGZC0vZa0eA6Hlpfrw9sDsFkg67EgFASqcISn8NnrR3WtgX0eYJiiB
         BDduXcTaaiAbeHefKin6+cKFewi4Zcqlbp5Gi7JVIM64YVbneksl33p0G0pbKWESOXIo
         Nh0PhsddT4i7NXLdqRGGGV8em+fgoPhEbaHJXd7teu5eshF33TJmPuIh7sKMAWxHevd9
         nbvnI1bgcdjdXoKImsVe4Yzkjkgyi8UeCiAO5pI36Z08etABtUJqDRH5r5OiqFEo5Z8i
         TgRvzRAJnox2hoPER6SV10X/5449W1/XnLkyMB3nB9M9k2h9AMxgzN0K4uwb++r+rEG/
         s2Yg==
X-Gm-Message-State: AOJu0YwA4ttm9tU0BEua9p1OjJxSRMbyPHKUvPxSTRkWPRhFZxDgUfMy
	GQpVVxMUEii8Dnpp02Ji2RB8ERGkBvQ1g/uJbdDpTzY88ZTabMMQbMJBibMXRA==
X-Gm-Gg: Acq92OEj8bmBfnqj8bxhjdx56HuVaPqYAS2qVRfV1G9X9c67vyVg7bCsK4szXkga5w7
	jpmdqFQpCVP0bnRfsN3XYKE3lTrZt1oWigVw9ggwhGw6jvR7dhouocw73nYSFyjdy4Tu4/UWFK3
	/1iX4me8DoPXLn3pX7UHcQmPPbkucT716rBtWqRaSnEUihHt43dQl6GeKRxTbYLmslWNvRGeOZ/
	/dribQTY+1F9KPhlXi4ypGrsWH7Zmz3wgqszG5bdqBgAyvYP8CgzqIvISJ37uK+VO6MFVWSv7vs
	0o9oRimrVrFFiQ+DEeeKqKDzIl5GLW8/98UwXjiL323Olnfao+Osip3HChe8dJLwgEklGsDsngC
	gFWbhe07jSIBVwwg0TbUwNV5Sx44CzI13405G+MBXuPVWeJOlvCO5kGuFgaK/rbrtR2nNYM44Py
	puiG33PY+VA9oyJyghFKojzYE=
X-Received: by 2002:a05:6000:1ac7:b0:454:a41f:d082 with SMTP id ffacd0b85a97d-45ea3ae5fdfmr2355942f8f.3.1779347397866;
        Thu, 21 May 2026 00:09:57 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45eaa7cf58fsm850498f8f.3.2026.05.21.00.09.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 May 2026 00:09:57 -0700 (PDT)
Date: Thu, 21 May 2026 10:09:54 +0300
From: Dan Carpenter <error27@gmail.com>
To: linux-fsdevel@vger.kernel.org, dri-devel@lists.freedesktop.org,
	Christian Brauner <brauner@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>
Subject: FOP_UNSIGNED_OFFSET abuse
Message-ID: <ag6vwpcCBN_VC1dm@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Is there a point to FOP_UNSIGNED_OFFSET now that everyone is on 64bit?
I thought the flag was for back in the day where we it was a huge deal
to access 4GB instead of 2GB.

It's mostly used in DRM.  drm_open_helper() forces you to set the flag
but drm_read() ignores the offset so I don't understand the point of
this.

regards,
dan carpenter

$ git grep FOP_UNSIGNED_OFFSET
drivers/accel/amdxdna/amdxdna_pci_drv.c:        .fop_flags      = FOP_UNSIGNED_OFFSET,
drivers/char/adi.c:     .fop_flags      = FOP_UNSIGNED_OFFSET,
drivers/char/mem.c:     .fop_flags      = FOP_UNSIGNED_OFFSET,
drivers/gpu/drm/adp/adp_drv.c:  .fop_flags      = FOP_UNSIGNED_OFFSET,
drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c:        .fop_flags = FOP_UNSIGNED_OFFSET,
drivers/gpu/drm/drm_file.c:     if (WARN_ON_ONCE(!(filp->f_op->fop_flags & FOP_UNSIGNED_OFFSET)))
drivers/gpu/drm/gma500/psb_drv.c:       .fop_flags = FOP_UNSIGNED_OFFSET,
drivers/gpu/drm/i915/i915_driver.c:     .fop_flags = FOP_UNSIGNED_OFFSET,
drivers/gpu/drm/nouveau/nouveau_drm.c:  .fop_flags = FOP_UNSIGNED_OFFSET,
drivers/gpu/drm/panthor/panthor_drv.c:  .fop_flags = FOP_UNSIGNED_OFFSET,
drivers/gpu/drm/radeon/radeon_drv.c:    .fop_flags = FOP_UNSIGNED_OFFSET,
drivers/gpu/drm/tegra/drm.c:    .fop_flags = FOP_UNSIGNED_OFFSET,
drivers/gpu/drm/vmwgfx/vmwgfx_drv.c:    .fop_flags = FOP_UNSIGNED_OFFSET,
drivers/gpu/drm/xe/xe_device.c: .fop_flags = FOP_UNSIGNED_OFFSET,
fs/proc/base.c: if (WARN_ON_ONCE(!(file->f_op->fop_flags & FOP_UNSIGNED_OFFSET)))
fs/proc/base.c: .fop_flags      = FOP_UNSIGNED_OFFSET,
fs/read_write.c:        return file->f_op->fop_flags & FOP_UNSIGNED_OFFSET;
include/drm/drm_accel.h:        .fop_flags      = FOP_UNSIGNED_OFFSET
include/drm/drm_gem.h:  .fop_flags      = FOP_UNSIGNED_OFFSET
include/drm/drm_gem_dma_helper.h:               .fop_flags = FOP_UNSIGNED_OFFSET, \
include/linux/fs.h:#define FOP_UNSIGNED_OFFSET  ((__force fop_flags_t)(1 << 5))
mm/mmap.c:      if (file->f_op->fop_flags & FOP_UNSIGNED_OFFSET)
rust/bindings/bindings_helper.h:const fop_flags_t RUST_CONST_HELPER_FOP_UNSIGNED_OFFSET = FOP_UNSIGNED_OFFSET;
rust/kernel/drm/gem/mod.rs:    fops.fop_flags = bindings::FOP_UNSIGNED_OFFSET;


