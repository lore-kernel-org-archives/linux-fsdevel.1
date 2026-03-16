Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89BE31D5170
	for <linux-fsdevel@vger.kernel.org>; Mon, 16 Mar 2026 16:53:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773680007; cv=none; b=md5osHnaQ1a6efpJTKyqNxYexTo4kuFVIYldsdDx5Jp6/6DbktspipiX8HrMMGbUJvRUH16tOucKGBdJmynYqgQRukRkbt0zeOrwdESB9i6tZluKDAl+ArwmnM/yKiKm4fGxEliaotX/9usDJ/GKbfeSiG+zwcoHzYbWm3q0O2U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773680007; c=relaxed/simple;
	bh=Y6atrSLAbnJfhZlZxbGqmf+S6hpn5gBSZAbEwi7HxhM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ZRT7401Jr+mmEXDWMdpHfx34icADEE17TXgWTqt4GQNSGBg52P02oi720KqHgDF3dNpFhWu9l5y8xWEEHGG75Lng9mcIzlGQKYw38974LKxJe7GdpAb72fx1KvQHoY41q4bJPnSKXFb+V5dstjK1pEPlL3/bNGoiiNDaAYVMlTI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=au3EU6bq; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=KY/8her2; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="au3EU6bq";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="KY/8her2"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1773680005;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=Bgin2ACqczlv1S6d0ES16EqD4Tf2wRzETQ7CmFvQb/0=;
	b=au3EU6bqoCdyRbuI4VLPOSB13r+m94509c9wR+8qD3NwN5MAGEIc5C3UQwFoCYtLjWr96u
	3W10geu/DeXwhnGV4eC0hBC0uGi+GKoJrDk5mxsG8e78xZdi3fmIYqqcSOrWrxWoswff6K
	5VS83ysNkIDfZ0wZ/G4hNhbOFZ+/4uM=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-463-ob4LKn_BMDuOUys3ekZRrg-1; Mon, 16 Mar 2026 12:53:24 -0400
X-MC-Unique: ob4LKn_BMDuOUys3ekZRrg-1
X-Mimecast-MFC-AGG-ID: ob4LKn_BMDuOUys3ekZRrg_1773680003
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-4853040372fso44588985e9.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 16 Mar 2026 09:53:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1773680003; x=1774284803; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Bgin2ACqczlv1S6d0ES16EqD4Tf2wRzETQ7CmFvQb/0=;
        b=KY/8her27VY6p1f5YcXKiTq0XyMAktkA180c36RV3dBMwFCMHzcRFmHqDgd918FCXg
         5W9F+wGLD9Ky9DrYwviiE5/oq8OG39YXnmjmsUCBVq+HBVuoVHacI3ziUap9YxUOHh0u
         dPAUNemxqP2+SPusZ9ga9eCt/mjXVbS7xse85gJyGWjko1wqAi5Y7i3/U/1ET0gQyIsb
         BfVIyXU9HvN8FTNOrPT9eoCVZ3prljC4HprobMOxk6x7UAQ8zwSDdQ+rxhfcj09k4EwM
         0o74kVsRzvoLkFcYnkid+eZphR/haEWDKiOGYUGkvtmDcgpJuOttb6tDwy0YmUbTNHDG
         kGpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773680003; x=1774284803;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Bgin2ACqczlv1S6d0ES16EqD4Tf2wRzETQ7CmFvQb/0=;
        b=ONruOTsXy3ivrPm5nvUbU1SwO83Uhr0yjcunWxvyPhWyq0oqU5cnP8nMSffIvGgDui
         iXRzVdabcIWdqRYCLLdFj+niInPbWlQO37YGyn3W4IouyROby65LjTJF9tQiB6sJmYmC
         KzPPfHhMabhwV8bov9Fh/DvAjC4dHVJa4MIvPplzySqt/RTH4+tRyJX5WLsJCTioDbKy
         4s58QKwHdFAQQB1MqaMELm0VjMftQd5IRpYi2XRlZMKecC57GEdQM9zPvLvzjXn40MvN
         JHSrnHIXdi+oJC5RjIjV7enDfvwhqAwchvk/y+eHzwGTEG2zfltk+fQzR08kqBXUewDY
         j9HA==
X-Gm-Message-State: AOJu0YyR6IZbPJbSLst5H9SCuUGOus4V0q7008jKfyMShUfnNwwqEYnO
	IosXAr5x4wb62qEXVfQlgerJQBnVkT/Rul7khhhPAvibA38fiZDHoyX1+H4MQ3ld9/fDDx6vx1S
	f2t40ec0R93flE9A2kXryhsUpAIYgGgRdYDR+1NBuesM9RtbcJMUIQqGgfFBomuYg3gywDEsQCV
	fUFtT3S67fuppRhiX98FHhozxISYcHfhULvSmCWAobyPR1E3VCJ0k=
X-Gm-Gg: ATEYQzwuxdG6AH9V6b7jer7fwFRa9HHCbbykBZ+XQxw1v21B2cLGJY8lDDV9ftP1QJT
	BIEkyOkjK69dL+pEiUoXEhc3eApX7h8MTN8QF2Lhci+7JLbLlwyi4560C3hhQi80c3hkKTzjS2Y
	8ny3yBeyKC13g7gBTLedWQRZqDhDXubVT/uhBxDUYTDMnHyXfeR8aAZ+PtStzUhaucTjIxbzRI3
	WyoiS0awoxqM9AaWA1EBqf2GS9HfjTazsz4I+ssOPYuMOTTYy9hgnQLfi2ecsQ8yoea/r17B56a
	4tK6zpREd3F5JhF7VdgtdQ8XVQlcicDCkVP8XPvfdqcc5PFQDhLDva8j8B7wMSC8IJn/aNy88Hp
	Vr6if9cqnRhpLui7M181t6qCoSV5y7vWgoXw1O3871zwBo1fYYCbWgvskiiGPaHl+neIoP1M6SQ
	==
X-Received: by 2002:a05:600c:a011:b0:485:6cd3:f7ac with SMTP id 5b1f17b1804b1-4856ce33d33mr36215215e9.20.1773680002866;
        Mon, 16 Mar 2026 09:53:22 -0700 (PDT)
X-Received: by 2002:a05:600c:a011:b0:485:6cd3:f7ac with SMTP id 5b1f17b1804b1-4856ce33d33mr36214815e9.20.1773680002396;
        Mon, 16 Mar 2026 09:53:22 -0700 (PDT)
Received: from maszat.piliscsaba.szeredi.hu (85-67-172-54.pool.digikabel.hu. [85.67.172.54])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4856ea9c340sm4978295e9.7.2026.03.16.09.53.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Mar 2026 09:53:21 -0700 (PDT)
From: Miklos Szeredi <mszeredi@redhat.com>
To: linux-fsdevel@vger.kernel.org
Cc: Bernd Schubert <bernd@bsbernd.com>
Subject: [PATCH v3 0/7] fuse: fix hang with sync init
Date: Mon, 16 Mar 2026 17:53:11 +0100
Message-ID: <20260316165320.3245526-1-mszeredi@redhat.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

v3:

 - fix (1/7) is actually trivial (suggested by Darrick) and doesn't need
   userspace update

 - the rest are cleanups

Miklos Szeredi (7):
  fuse: abort on fatal signal during sync init
  fuse: create fuse_dev on /dev/fuse open instead of mount
  fuse: add refcount to fuse_dev
  fuse: don't require /dev/fuse fd to be kept open during mount
  fuse: clean up device cloning
  fuse: alloc pqueue before installing fc
  fuse: support FSCONFIG_SET_FD for "fd" option

 fs/fuse/cuse.c       |   2 +-
 fs/fuse/dev.c        |  97 +++++++++++------------
 fs/fuse/dev_uring.c  |   2 +-
 fs/fuse/fuse_dev_i.h |  34 ++++++--
 fs/fuse/fuse_i.h     |  24 +++---
 fs/fuse/inode.c      | 180 ++++++++++++++++++++++++++-----------------
 fs/fuse/virtio_fs.c  |   8 +-
 7 files changed, 198 insertions(+), 149 deletions(-)

-- 
2.53.0

