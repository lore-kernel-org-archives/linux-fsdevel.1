Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58DC31B4138
	for <linux-fsdevel@vger.kernel.org>; Wed, 11 Mar 2026 21:51:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773265886; cv=none; b=nTVHTGeo0vYYMfTggXw5WXxTEorLax2DjICQ7B0gkvbq3s7MqpMX7apBGYI3mZjZ9vPzB1xbPv7gemLjQ/atOqx+GeCI4apuFlDA9J8m0pcHlYyTPE2YgbrhqIRugoTRztx1KCS4Ac+fYI1x9EqPzLcpTMbsB7CfUheX5gwfk8U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773265886; c=relaxed/simple;
	bh=WEXX9kX1v3SKw02NoBppW4iAS109Lktx5icaWVtx3nU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=CzphY75PWDdQj+1xjb07eoPiI55MdO8XPzNNgaXJo0DKb5J6AJwqNAI1Nk3nhi5esulFqTEPNIlwAD6GvFYa60Z1Pnu8s1b9TZfa4ATbxFr0SwikeqKSsIIJLaeE4spf3FPVphNYKeJARtURBoyjiYO5zFMUN9CeonTRCsmKsB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=L4WwLDdu; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=NFIqvzvQ; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="L4WwLDdu";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="NFIqvzvQ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1773265884;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=zt/tDh13ghPJAPcWu/Cc09LyuEF9DYR5x7ce4MCJ2O0=;
	b=L4WwLDduFtu/t4Wt/XcyRy5OUltw3Q8TrLCSoVVQg4An9a6atC8z1VlTE5/abIK/iuniU9
	sfIV2aih96dpAWqgIKlTFcklgSMgoi/xSnempS4MdFtqavL6mSnIcjlwxuIrbXk+qSXWyF
	aAD6QBY7br0S54hLcTYnN0bIgJ0YEbc=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-327-6iPGZB0XMN2z22dvcaZDyg-1; Wed, 11 Mar 2026 17:51:23 -0400
X-MC-Unique: 6iPGZB0XMN2z22dvcaZDyg-1
X-Mimecast-MFC-AGG-ID: 6iPGZB0XMN2z22dvcaZDyg_1773265882
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-4853ac455b2so4282355e9.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 11 Mar 2026 14:51:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1773265882; x=1773870682; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=zt/tDh13ghPJAPcWu/Cc09LyuEF9DYR5x7ce4MCJ2O0=;
        b=NFIqvzvQBusuN6ZYutZiE498H6JRjInEbDK63IHQxFers3UoHa6JR2hFB8Ppmg+ss1
         UxeZ7e9BfXO9u47MLhCN4EHZ/w3j+DAx6LQRUPp+v+yHmBqqHbpb+pHGJQd6aa3M37nA
         bMR1fPflZkk79RSqGdUt8qYwpsQWIc2qjp4taRw10xZdwFiEDHFM27dKy4DRQ1tbTlZi
         p7iNYrAfrU9VAu6oj/ikFnOrev5QcdLAYLPWRy3dj4GAW7nxx0qWQLNCO3zMoJYNAF4Q
         L9Zq5R0xssPseE4pj5Wr7M2IUlLRSRtZ6bBTmO6qQL4bmlanAvpTYnMm4J0UuSMVamDZ
         hlFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773265882; x=1773870682;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zt/tDh13ghPJAPcWu/Cc09LyuEF9DYR5x7ce4MCJ2O0=;
        b=rT1y/5RDDiEjRXItkUZFzjQ8Qwc5Vus9KOT44jBsedLiklbCAlNdj6S4FIifYNmJEa
         4gvxNUjCwqKtmPtDvbeBiUNca812+Yd54hTimAOa+JzoMi0DZFJpCI0+plyhs8+ivlQX
         5HpDaDCO6L5qXoKHAp5e2Qrbad1+3i4grlNhLUMBWHsxyf2i0eSxEdDFGMbwuC9iean6
         m711rLJ3kXo/KFfarhKfXmqLK5wpR06V/Is9n6HDbW7GVuaPrre9p1ooz4jMGEAtn3Ne
         Inecwmia3JAU6pF2pQ6ydlSEx2wh5s+80oACsniD5ikSu2L6fzzXCpK3oXtWc8JxpIyW
         20tA==
X-Gm-Message-State: AOJu0Yxj96o1sNh988/lG9sldOQJrNRBK32E4M6bnTrT1hHmHWb+cI3w
	OgBCgc46TwUzIcqqkUDeML8xVZCSpKq1GeT21/ZKrEmotZnm4p8eC9NREY+Ud61UcN/y/UhSD1t
	5ajCmVixGqBwRm+bZKCe5Ll29ia8UvITUN2KYmxpl95NZqowd4Aldl7MNLzdnJPcfikTl/K2yrx
	YZ7/N4MWZoVcmz2A4+DcLUK1nyp52ownY1vCXN1yuLJHpo4md2s4I=
X-Gm-Gg: ATEYQzyGIv/P76eDvPscWsQWnBzScR3gCGaAbBV659Wnkwg2bTmcbeUJG/98E9jXawg
	fkG6Pv9mLvf1XJacIuDrZwOpIT2OPjiaPzso9cmcteqwb9XTLzbo550e+qtvzCAzOBav4C8ngN4
	rzQQcoAAGEWO2Dop6B5e6DKR0NUfwHAOBi0zFm/RBhZD44qaqnibp1oLErb08YNfu17whMCg8BG
	1ucE5OUceqatUMEQubhUf7LXJ46nw8IJdCM6nr4eYY8KddMUxKZhzOxcPaRmELLZEZo7nXzT6FC
	ORbN9SKNtHeGP7uRw8DdC+4rNCoZMDuqEi6uIEOlGyEynVtWLkSgK9F9w+tE+WQpqSL1K9ht1OD
	ty46iKz2be8yAS3Aa5P2NBUX+MXETa4ow6CkOeB5/viimpgESy4fgLs3mCLp8hZT5JrfGl5Z6hF
	9nCFI=
X-Received: by 2002:a05:600c:1f96:b0:485:35d3:ce59 with SMTP id 5b1f17b1804b1-4854b0c737fmr69283385e9.10.1773265881672;
        Wed, 11 Mar 2026 14:51:21 -0700 (PDT)
X-Received: by 2002:a05:600c:1f96:b0:485:35d3:ce59 with SMTP id 5b1f17b1804b1-4854b0c737fmr69282955e9.10.1773265881163;
        Wed, 11 Mar 2026 14:51:21 -0700 (PDT)
Received: from maszat.piliscsaba.szeredi.hu (176-241-63-127.pool.digikabel.hu. [176.241.63.127])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4854b5e9179sm79881205e9.3.2026.03.11.14.51.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Mar 2026 14:51:20 -0700 (PDT)
From: Miklos Szeredi <mszeredi@redhat.com>
To: linux-fsdevel@vger.kernel.org
Cc: Bernd Schubert <bernd@bsbernd.com>
Subject: [RFC PATCH 0/3] fuse: fix hang with sync init
Date: Wed, 11 Mar 2026 22:51:14 +0100
Message-ID: <20260311215118.2891117-1-mszeredi@redhat.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is a first cut, with minimal testing or polish.

Code snippet from the test server:

static void *lo_mount_thread(void *data)
{
	struct lo_data *lo = data;
	int fs_fd, mnt_fd;
	char opt[64];

	ER(unshare(CLONE_FILES));
        fs_fd = ER(fsopen("fuse", 0));
	snprintf(opt, sizeof(opt), "%i", lo->devfd);
        ER(fsconfig(fs_fd, FSCONFIG_SET_STRING, "fd", opt, 0));
	close(lo->devfd);
	ER(fsconfig(fs_fd, FSCONFIG_SET_STRING, "rootmode", "40000", 0));
	ER(fsconfig(fs_fd, FSCONFIG_SET_STRING, "user_id", "0", 0));
	ER(fsconfig(fs_fd, FSCONFIG_SET_STRING, "group_id", "0", 0));
        ER(fsconfig(fs_fd, FSCONFIG_CMD_CREATE, 0, 0, 0));
        mnt_fd = ER(fsmount(fs_fd, 0, 0));
        ER(move_mount(mnt_fd, "", AT_FDCWD, lo->c.mnt, MOVE_MOUNT_F_EMPTY_PATH));
        close(mnt_fd);
        close(fs_fd);

	return NULL;
}

int main(int argc, char *argv[])
{
	/* ... */
	if (ioctl(lo->devfd, FUSE_DEV_IOC_SYNC_INIT) == 0)
		lo_start_threads(lo);
	else
		/* ... */

	pthread_t id;
	PE(pthread_create(&id, NULL, lo_mount_thread, lo));
	PE(pthread_join(id, NULL));
	/* ... */
}

---
Miklos Szeredi (3):
  fuse: create fuse_dev on /dev/fuse open instead of mount
  fuse: add refcount to fuse_dev
  fuse: don't require /dev/fuse fd to be kept open during mount

 fs/fuse/cuse.c       |  2 +-
 fs/fuse/dev.c        | 48 +++++++++-------------
 fs/fuse/fuse_dev_i.h | 15 +++----
 fs/fuse/fuse_i.h     | 13 +++---
 fs/fuse/inode.c      | 96 ++++++++++++++++++++++----------------------
 fs/fuse/virtio_fs.c  |  4 +-
 6 files changed, 83 insertions(+), 95 deletions(-)

-- 
2.53.0

