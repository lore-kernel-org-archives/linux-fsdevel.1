Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 928113FE36B
	for <linux-fsdevel@vger.kernel.org>; Thu, 12 Mar 2026 19:40:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773344427; cv=none; b=CllCETSeOSZoVFg7WW5y4hbE7Yuso7xnXKe9sq4OicfrQ/gO7mg1QUHEjWMq2r1t6Xf93m26Wc8u4o/dG4c0D8vwEv+oh2ohH2AbbuYbQ4xUXp5CUtBpFy14ZlmqCysnOIAE2mqPNS+a7MBqDYVuHRJSEupIUKMFI7dxh5HwWeA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773344427; c=relaxed/simple;
	bh=NwLD+wMakVGAoa40V099x3pawB6ymTuSq2IfoqKizCM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Ov+yb8GCOdylMmZXqUVp1Hr4Xil16Y8Ias4I+yhG2SbVJnFbV6TWTzcj7yVGc7e1TCp+Glpwt0SLtn4NDpbdmwf7rHlJJ/dBdPeqG2xc658SJkYVGj2rvhECf0+diZWK+6C8Lr95opybfp2JgLVzZLYPguOW6XBmYMPmTHsUUJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=aVxbx3A2; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=c1YKlFvt; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aVxbx3A2";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="c1YKlFvt"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1773344424;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=dNpDerfIa74pDuEM+d7CDbRUeWc0xfxCI9J+rb5+qWc=;
	b=aVxbx3A2I1TXLCifgNdU57qC6X1Gr5w5sB61dWXMpr1rZNq+GU0ykBQF+HjnHduV9xITHa
	mBu7t2QlNBsxT77WSvytkSVbSj0MpvXKXDqWyZRS2jatc/SlCMHLgT/c+oTR6jJq6RI4YY
	0Y2xn90WueUcY4Q0GjW0SMTqeU3EfsQ=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-116-AFtU6h3EOMOJI4UPm6o7nA-1; Thu, 12 Mar 2026 15:40:23 -0400
X-MC-Unique: AFtU6h3EOMOJI4UPm6o7nA-1
X-Mimecast-MFC-AGG-ID: AFtU6h3EOMOJI4UPm6o7nA_1773344422
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-4853ac455b2so13180455e9.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 12 Mar 2026 12:40:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1773344422; x=1773949222; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=dNpDerfIa74pDuEM+d7CDbRUeWc0xfxCI9J+rb5+qWc=;
        b=c1YKlFvtdSlTf+RJXXiNnrfyIRnZPZJuVN5w5Roi1HO7etJC/18Zz5zV3VEY+22hfI
         klTUQDr2EqL7iSGgb2Trr3j7XnHo0lehXmWhCCzudCyWM4Qe8cEnZWCA5GVwlVImtqL1
         q/4C7FZj7eZWQyMaz3ILzis0nXswpPmFKmSoTKhfSqhk90D8rHjga2D6smxNp1nO7d1I
         ZSeGNbi1YBHKM1h6zVryseyRQyqZiKqY5UW19UH17e+sFL4MVAaFSFKelh1zV2/o4NMH
         LpT3aWV8uPK09XpBGaXe6Svxs4mI3CY5CtX4EAVrshSgffz1EHYN6AEpJHO5dEV1RaOk
         29HA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773344422; x=1773949222;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dNpDerfIa74pDuEM+d7CDbRUeWc0xfxCI9J+rb5+qWc=;
        b=oDNySTASIzBH2yPDT4uHPAl/wwyvHteB+zIPZGfe0ituM7tDTVTYfuIy6zbcGgCcSk
         7ir3TbGQRbSWXhkVR80klUTFAs/pQF6op/FDe6xR0WMp6yJlD8zEm9tBc6U6DTC5OvRG
         nZBY95b+0H4cbSOWpGxOStDZSBYHSAu6uKLLS4Wh1bhBE81/J2wzG34w8EKNQLqpgNah
         YGNDswxAbK4G3Ii+a4wX7uNy7b4TTqMOhfEBz65mcfYU7QsIdgMvLUnsKL9OCNljvdSd
         wwJ9BaURsQSphOGaFo9AJOVH6j/OhKgeGu2SZXFJeCS1X/pj3msrwmax7p+QPo0gAzMf
         qwLw==
X-Gm-Message-State: AOJu0YxklK4gD2G+YmX2gi4vFCdmYoTD2AdLHsH8aJvEM31kZybp0QZJ
	MuCoV9gpoOUMxCGv/cBmcCNTflld0CdCKJohuULeIj/c0ruQD73PJymLhBot9OaiV8Nm4BOCTmP
	KLt4JWMX7BHrEpeQE+AY//AxXj59WS24ShfhZNDLvodma5TszLv2R5Lk7zKwc37WUobik7MM4rS
	vFjWB7bQCaJOsVe/ajLuSnj0Xcz8/qN8xP2fGacXiJf90jhoIrok0=
X-Gm-Gg: ATEYQzyQ7FlR0IO99qz72GJnMhMsYZqjKfVHPpLw+ymhwDYtmp3SFrkhDaYwv3GjPEE
	jZkgDQ2lv69ygMQ7DgYNJm5W8pt7d51SZUu5GWOmwemjWGqD5jw4xkMJ1R1cnUCkvi4wg/aO7YR
	t6St4ULoyRej6nQroLhVv1ZweGbi2qGy058M15vrkt3D00fC55jTXltFw7tUx2Ulfoqxm1xViLW
	CDIQx6ecVpM7feKl9oneu14iLZl81uhl85ab/xObF9VL9DDS+jSsPBwo41oLI2bpnFY/Jji9xbD
	ijcoUd0XeOCUu+IJVKOW6Xn3gMJjjAgxpqbfaPZ4XnmovyzTPrirVNhRW/sc5wYlByc1/sm4V2+
	IcU9wZWX8OPOaocDx/E198vSkrqCiCpILMAc/3ZIGcq88mo9cRvDWZiV+oZxdfdDnvGRoyJ19F6
	pEgt8=
X-Received: by 2002:a05:600c:b90:b0:483:709e:f239 with SMTP id 5b1f17b1804b1-48556714ce9mr8588465e9.22.1773344421743;
        Thu, 12 Mar 2026 12:40:21 -0700 (PDT)
X-Received: by 2002:a05:600c:b90:b0:483:709e:f239 with SMTP id 5b1f17b1804b1-48556714ce9mr8588125e9.22.1773344421195;
        Thu, 12 Mar 2026 12:40:21 -0700 (PDT)
Received: from maszat.piliscsaba.szeredi.hu (176-241-63-127.pool.digikabel.hu. [176.241.63.127])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4854b5e912fsm396705955e9.2.2026.03.12.12.40.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Mar 2026 12:40:20 -0700 (PDT)
From: Miklos Szeredi <mszeredi@redhat.com>
To: linux-fsdevel@vger.kernel.org
Cc: Bernd Schubert <bernd@bsbernd.com>
Subject: [PATCH v2 0/6] fuse: fix hang with sync init
Date: Thu, 12 Mar 2026 20:39:58 +0100
Message-ID: <20260312194019.3077902-1-mszeredi@redhat.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is better polished, still needs more testing.

---
Miklos Szeredi (6):
  fuse: create fuse_dev on /dev/fuse open instead of mount
  fuse: add refcount to fuse_dev
  fuse: don't require /dev/fuse fd to be kept open during mount
  fuse: clean up device cloning
  fuse: alloc pqueue before installing fc
  fuse: support FSCONFIG_SET_FD for "fd" option

 fs/fuse/cuse.c       |   2 +-
 fs/fuse/dev.c        |  89 ++++++++++------------
 fs/fuse/dev_uring.c  |   2 +-
 fs/fuse/fuse_dev_i.h |  30 ++++++--
 fs/fuse/fuse_i.h     |  21 +++--
 fs/fuse/inode.c      | 177 ++++++++++++++++++++++++++-----------------
 fs/fuse/virtio_fs.c  |   8 +-
 7 files changed, 181 insertions(+), 148 deletions(-)

-- 
2.53.0

