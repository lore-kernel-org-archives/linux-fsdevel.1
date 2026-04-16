Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32319399340
	for <linux-fsdevel@vger.kernel.org>; Thu, 16 Apr 2026 09:17:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776331029; cv=none; b=D1sYySOXmgY2QaMthfv0RwGwzA9Ch2h0jUz8ypTU0MUEQnS1ZefTzvVJ+flRYaxYg2EIhzE4zOMklSY4MFuQzqDQDI3q6fsPFy/bC+TctN6It793HdpRh9GBU3IAJRUOLCWaPUWGGXgqE8LCOoRPgJRzdyRveS4vTnsqDXNxAPc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776331029; c=relaxed/simple;
	bh=5lOOeS93Ex1//iVA+tkjACjRddJgY2SXMx3Driki+fI=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=ALeGvBZWHfrUPl2nqNORfhjj3Zm7zUAj86GsZvpRk8XJu6e33YjR0fHPTlQCXDgT8ShFkjvxjcbYFTOeN8bCow0TC49uGIc+6YnvsWxGdl5CuBi9e8sx+1possei2Ixv/Vw8d8jYn1oA3vAQcqsGT31h/Fbh8i34cSZ/MK+bobk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KJEOMNWu; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=cHmIKx2L; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KJEOMNWu";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="cHmIKx2L"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1776331026;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=WkJltErQxX9gIhMzzhVZFKWgEdEnTbltAdkoFS13j7U=;
	b=KJEOMNWuk9YC0HFvZ8ZuJrYbgV2RF51w7vVpGWMB/naOGhVBmHyzMjh5o8JHLSed2fv4Ow
	0JwfyePzRq5SMc1nzXyvPmZRZUZnWBNdCzWUpZDr4VoFTBPk083ddxXBJwVPlcdggMOHTy
	z/l3/lA61U0FKmEn26gK+/8Fw+RhyXU=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-499-1RgHrUFHNnqUUBvzPN3DxQ-1; Thu, 16 Apr 2026 05:17:02 -0400
X-MC-Unique: 1RgHrUFHNnqUUBvzPN3DxQ-1
X-Mimecast-MFC-AGG-ID: 1RgHrUFHNnqUUBvzPN3DxQ_1776331022
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-43d121c4271so4918436f8f.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 16 Apr 2026 02:17:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1776331021; x=1776935821; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=WkJltErQxX9gIhMzzhVZFKWgEdEnTbltAdkoFS13j7U=;
        b=cHmIKx2LsNaAXBcO9rujUxMrMH0N7E+36IBmKbX0al01VIH/UeEiWASNsNUkQJYZkv
         MddG0ite3BP+cUZ7m3pNAo37SxgEEEgY46rLcV5wFcfMJ84UQaMqMzfHDTe+CrAwmhgj
         KNlh41jx62woTlFfOO6gAxS2gjS8UOxKW+KzL7jfYRzQpV6MIrePNoGwMT+VcYxr6kTo
         rL3i7dwHxbO0wFVnQJjoU4LMriI9uCtytnVDQaCdsV2nNW5fx/tOf6dFDxYXEa+SWjmR
         PCDFdSb+6ek6UoNZgs6+JLLFCXUEDdp1RVhPmgTE/z17w17O+/OmB7jEZqRibOzpm9Km
         qi9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776331021; x=1776935821;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WkJltErQxX9gIhMzzhVZFKWgEdEnTbltAdkoFS13j7U=;
        b=hhf4I5BqoLlPsBU0q+jKr/qgI8Vd4YwhgdOUaTZE5rNCf4wOfHH2Qj/hobt6AvFl4Q
         WN2RINXkLSD/7Q2xiyiTmC555oM57HSo+jL1Yn3gEoHZDgn5M6aLNff+0vxdGiqOYa9R
         SUVX9FQA1lyUFKeUltQ6OnVNWbYXAo+s18U8xVyZYoTY9f1zUC2KLJbZgmNO+QqJEXIz
         Y16FJ5gcY4zqImM4ut/bpw0yRglgJTN05k7xJY4dgCPckoukYUgxLlz/cRsYs06+iYq0
         MuExv4j3BvgANs9UKZFiX7DTu3GjHteTX17UfTUu7CiyDa9fOFD5TpLafv3/J29bRLXJ
         p4GQ==
X-Forwarded-Encrypted: i=1; AFNElJ/inRp4tMcyGstCM/2NHDRMXBbCABLE8O0Kil8CO47Z2czKv8ORENchaGpN/CbLvy73PUF3T4IY699DlRNy@vger.kernel.org
X-Gm-Message-State: AOJu0Yz20icQsJQANjqmdPY12B6AnDjByC7LeIsGO3m59WqELHJPEgxf
	QfhAdQOHtbY/Etv9w9OHJuj8n47WvmTtFXg16nqBcTP8fI45KpIKm6TD0/ImqWz4B2M/1fe01Km
	wFHaauSjCd2XoOikZ+Cs1QlJv4Vdof/q2327b+89f74MbesAncvr8MtR9hNmVAckI760=
X-Gm-Gg: AeBDieslaFEAmLl2BheAXkw/Abeu6Z/cw/FoXBTl7XxnQ6eMDo7V2VZcMqMssbB5kei
	LqdK1aajYc8Upb/e59la7KKFQoWO9DDkGfY7zW1wiR2mce1zEmlDBt0ulcMOMBc5Yn/AZuciffs
	j1sh4wywYBPvS59ZPgryFXKfDnsZa3YlCX+e4PwoiKjUesdvWKUqky3YTyCcRLncVCVtO2hPn+e
	LvR+rwpJsz96Cy/vZD+CZkNAW5q/NJqTEnozGuUCjvdnEztUZLEchUjhI9mncfy4xqtoF2uvq3T
	QZ3mMFCYhAxw/9XmcX5Wz5R7qjX9jru4SbElc3lQqa7JmyKpB3ounNnj9TtI+maKwDzPNNOWU9f
	MqLE/lcr3jH1Fha21i9Wu9e52B8HxVUiPFmq5NttOi+CIxtAKaipn9sIYKGj12mr+U2BYIc4cXI
	UF59uLew==
X-Received: by 2002:a05:600c:630d:b0:488:79a3:f04c with SMTP id 5b1f17b1804b1-488d687cfd0mr344058925e9.27.1776331021389;
        Thu, 16 Apr 2026 02:17:01 -0700 (PDT)
X-Received: by 2002:a05:600c:630d:b0:488:79a3:f04c with SMTP id 5b1f17b1804b1-488d687cfd0mr344058355e9.27.1776331020797;
        Thu, 16 Apr 2026 02:17:00 -0700 (PDT)
Received: from maszat.piliscsaba.szeredi.hu (85-66-37-19.pool.digikabel.hu. [85.66.37.19])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488f57d80d3sm38597975e9.0.2026.04.16.02.16.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Apr 2026 02:17:00 -0700 (PDT)
From: Miklos Szeredi <mszeredi@redhat.com>
To: fuse-devel@lists.linux.dev,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH 00/32] fuse: improve transport and fs layer separation
Date: Thu, 16 Apr 2026 11:16:24 +0200
Message-ID: <20260416091658.462783-1-mszeredi@redhat.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series is based on fuse-update-7.1 in
git://git.kernel.org/pub/scm/linux/kernel/git/mszeredi/fuse.git#for-next

The transport layer encompasses:

 - request queuing
 - request timeout
 - data marshaling
 - device I/O

The filesystem layer handles the rest:

 - VFS <-> fuse API translation
 - caching
 - notifications

There are misc functionalities, like tracing and control filesystem, that
don't belong to either layer.  Also cuse.c and virtio_fs.c still have both
transport layer and fs layer parts.

To aid separation, the fields used by the transport layer are split out
from struct fuse_conn and added to a new fuse_chan structure.

Transport layer internal headers:

 - fuse_dev_i.h
 - dev_uring_i.h

Filesystem layer internal header:

 - fuse_i.h

Headers describing the API between the layers:

 - dev.h
 - args.h

Next up: impelement a stripped-down local-only fusex (experimental/
extended) client that can be the base of further work without risking
stability of the main one.

Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>

---
Miklos Szeredi (32):
  fuse: move request timeout code to a new source file
  fuse: add struct fuse_chan
  fuse: move fuse_iqueue to fuse_chan
  fuse: move fuse_dev and fuse_pqueue to dev.c
  fuse: move 'devices' member from fuse_conn to fuse_chan
  fuse: move background queuing related members to fuse_chan
  fuse: move request blocking related members to fuse_chan
  fuse: move io_uring related members to fuse_chan
  fuse: move interrupt related members to fuse_chan
  fuse: split off fch->lock from fc->lock
  fuse: add back pointer from fuse_chan to fuse_conn
  fuse: move request timeout to fuse_chan
  fuse: move struct fuse_req and related to fuse_dev_i.h
  fuse: don't access transport layer structs directly from the fs layer
  fuse: move forget related struct and helpers
  fuse: move fuse_dev_waitq to dev.c
  fuse: remove #include "fuse_i.h" from "dev_uring_i.h"
  fuse: remove #include "fuse_i.h" from "req_timeout.c"
  fuse: abort related layering cleanup
  fuse: split off fuse_args and related definitions into a separate
    header
  fuse: remove fm arg of args->end callback
  fuse: change req->fm to req->chan
  fuse: split out filesystem part of request sending
  fuse: change fud->fc to fud->chan
  fuse: create poll.c
  fuse: create notify.c
  fuse: set params in fuse_chan_set_initialized()
  fuse: remove fuse_mutex protection from fuse_dev_ioctl_sync_init()
  fuse: change ring->fc to ring->chan
  fuse: remove #include "fuse_i.h" from dev.c and dev_uring.c
  fuse: alloc pqueue before installing fch in fuse_dev
  fuse: simplify fuse_dev_ioctl_clone()

 fs/fuse/Makefile      |    3 +-
 fs/fuse/args.h        |   65 +++
 fs/fuse/backing.c     |    1 +
 fs/fuse/control.c     |   16 +-
 fs/fuse/cuse.c        |   28 +-
 fs/fuse/dev.c         | 1239 +++++++++++++++--------------------------
 fs/fuse/dev.h         |  110 ++++
 fs/fuse/dev_uring.c   |  139 +++--
 fs/fuse/dev_uring_i.h |   37 +-
 fs/fuse/dir.c         |    9 +-
 fs/fuse/file.c        |  146 +----
 fs/fuse/fuse_dev_i.h  |  342 +++++++++++-
 fs/fuse/fuse_i.h      |  412 +-------------
 fs/fuse/fuse_trace.h  |    4 +-
 fs/fuse/inode.c       |  255 ++-------
 fs/fuse/notify.c      |  434 +++++++++++++++
 fs/fuse/poll.c        |  141 +++++
 fs/fuse/req.c         |   99 ++++
 fs/fuse/req_timeout.c |  148 +++++
 fs/fuse/sysctl.c      |    1 +
 fs/fuse/sysctl.h      |    9 +
 fs/fuse/virtio_fs.c   |   21 +-
 22 files changed, 1995 insertions(+), 1664 deletions(-)
 create mode 100644 fs/fuse/args.h
 create mode 100644 fs/fuse/dev.h
 create mode 100644 fs/fuse/notify.c
 create mode 100644 fs/fuse/poll.c
 create mode 100644 fs/fuse/req.c
 create mode 100644 fs/fuse/req_timeout.c
 create mode 100644 fs/fuse/sysctl.h

-- 
2.53.0

