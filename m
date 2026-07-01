Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D723431E7C
	for <linux-fsdevel@vger.kernel.org>; Wed,  1 Jul 2026 20:51:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=170.10.129.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782939081; cv=pass; b=RIFCLxrr/r3Vf+TeXlcYasSbU+Ppp6ehLOrAsN0P9fGhblLDJTnY0lWHAQ9IuNyzAsXnSKt/fjoNp+teDNwliZEkRY8SSGMGK8td2XYGyhKifQz35Y6yr6vpjfnZD74UA5KSdSd9znZ2vv6fs0lqziMpbWRRV9HoKUoIhLa3VVY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782939081; c=relaxed/simple;
	bh=CXbyE5jAZaxhOqn1wsrHntSB48IwpOuSpEKralUyb4c=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=DAMrUgsgbSCW1HFDuzQRv/zXW4TUcOGK915OzXJyfeqC35shb1glcm38G7WSsUW05gtvcHPoECghfdeItw/t/HYnrxJSUes2mrY44zEs6O7J3jIZnbiOPtquoAO5aJ94i+lKby/bTFzBpBAsDQrzYxfjhqGP+JLPptxUM24gUxY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=M8d67CwD; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=FnJq9Fph; arc=pass smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="M8d67CwD";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="FnJq9Fph"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1782939079;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=XF81/sKTmZ1AnlJSj3x2T7mD8T/hF0ps/9K/nqtvitg=;
	b=M8d67CwDGJgWwxhIubBTlpkFwjw7Fz+LyeDmRbAtbDgDKJ7unua66X0YgfLWXcSg4O/Bmo
	oYcmbo0g/MCWAwGgJteUXeTDW09mZ2YWbtj8GUSiqhklvqfMNVwbYkIcFRHdmostnV2u0m
	WN7ignq9bbi1+9h7gUTTBY2y0K6U8b8=
Received: from mail-yx1-f69.google.com (mail-yx1-f69.google.com
 [74.125.224.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-207-86O33AJSMe-9twnAUePb6Q-1; Wed, 01 Jul 2026 16:51:18 -0400
X-MC-Unique: 86O33AJSMe-9twnAUePb6Q-1
X-Mimecast-MFC-AGG-ID: 86O33AJSMe-9twnAUePb6Q_1782939078
Received: by mail-yx1-f69.google.com with SMTP id 956f58d0204a3-664e1e408b2so3031382d50.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 01 Jul 2026 13:51:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782939078; cv=none;
        d=google.com; s=arc-20260327;
        b=P+wjTCLblzye9na/gIf2LRNnwjrko7PBmQX9U+9nDO8ZUQFxsr3NK5/t1valuyRaj/
         FF2NG8ZtbT0/h5n27+t9TwAgu0Jn4CqkO+ivBGnUzH1TG6BZDEE82kKheTbmMc1JvHNN
         kz1T97cnICqDHcVdQSMwlFu7XgSAWAfijqRF3A5HYV1DJ0RHksseweR12QY/pJDlcQz4
         VR5HrddO/ulY8YwqHXMPcaEbKeghviwbmtilCCg+JoRzh3Q4UMCWuh4j8tPme46ToBL4
         3KU47DQEY6s4hF7n4USWNicQMP6iRG2P5C0DXyZC6GJQqG6HUsdyO4ghR4zOOrhdmPKz
         KbQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=XF81/sKTmZ1AnlJSj3x2T7mD8T/hF0ps/9K/nqtvitg=;
        fh=jFuoDLZKfyTgTKe5dfJAOMilC1EA5KIRvvq0h6L6NL0=;
        b=Bagatkv06pNQmVFGCh+8HlZF7y0CIlQZd70aRtPlUs6hrgdX/l+8S8fJLzF1HKYqIf
         Wr2Kzhspr6ju6fVz8iBSbi/acrZ+atxUkqq3SQv81Pll0OiQi814yj1TBV7PPiZISjhY
         S2YsiF6ebmwaXj2qZHZA/fycMIwqdCZMT8oXRiZSXBJG58da/IdSPn7J4bVbf8R/zrC7
         3RERrDK/Uvz3nyuwp76iczhGdThFCL+sRMsP0szEci2XCxP3hGNryUCcIW46/QuXYg4y
         MKGe/P2DWJ3uAHVT2j+uR8yVpRiue+H3aorvfqnFQUpOn10tCHaQMdMnIlhfeK+7H+LW
         sZHw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1782939078; x=1783543878; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=XF81/sKTmZ1AnlJSj3x2T7mD8T/hF0ps/9K/nqtvitg=;
        b=FnJq9Fphx/rnHWEzC9BSjCn9AnYdWao6r28p8TvhNE0XHR68BvjjBo0YSh58phMWWM
         lF51OvwSYcjTVWOeBFhCRcFMOQs1+OXHKIlgqN60o0DuJvukP/UjBNNNgFVLRLqkS1Gf
         Va3vVrn+y+soUUWiLBFyNXO+jQ993UjZNmpj78+L1oWmiSvwsXj049ZpRs+rQCDeYpsB
         +7EdO3qSzOflCK5Ioz6q5TbFNyfyC5on/ooVyw7jgwzcqdVbubC+ArCAi3sYsWmHtvni
         WTx/mf0kebO8Qv3s247sR8NuatuSiT1mspks55In8XTrWz/G8T+Hxqlltxcs+7Xtqa2Y
         JwWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782939078; x=1783543878;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XF81/sKTmZ1AnlJSj3x2T7mD8T/hF0ps/9K/nqtvitg=;
        b=KuW4OMtw1jZdtvdbyAHheQMDHhCCPNydxOqIaTDfoBUMTRZoyKDFKGf/ycMNz361DC
         LqFVtbMDd06mSEFLJZmjmO/hJfl+wVzEu0QpgaZtzKOYwK5qJOsRrBs0olq7/sqg1gKO
         xzXSal+D342NFxJNHdeQf4l5HKJRbXpATmK1O3VgO2EjKlTWi5KDEqZ1ocHKJTzryoZk
         q+qxXZAOreLBuQFSn0/dePYc7fqafrb+Tiztg66BZRfZpqVcufnp1SXPEZTZgNM6v4BT
         IuaJ+8bkoGgaV8J7apr1QCWbTJ/kUcHT6Xqd9pMbKDQQ2ZUX0LIXglwEObYwwpak/Ggr
         ROYg==
X-Forwarded-Encrypted: i=1; AHgh+RqYHsvpfhnZs0K0pPEgpSSv8nBeaRrFvUhGjVBQ4FBuuZYibC3HhoDkUHC1HJyLHqAsGPRrwYOqv8U+Z8Fs@vger.kernel.org
X-Gm-Message-State: AOJu0Yxj+PXnUVoSrEx9zW/PVPJZ2WMVyEHEcQ+iNh8n8+Q+KG7d83Zj
	WeP5PtZle7QWgMsuh6YEZWABxPEcAypRTYqy4rJJfN1ILPvY+NF2EzMGAl6RpGSO/W4h6eU7YOm
	Zoymjlu/82Na9tizhAyWzl3QxnTz97hSF6lbgPOTNBaaP6CSEqG1K0wc2cQqTbXcBEe99PglWqm
	m8C7jHha3aLnhy/wfC4CiE+nsjtT5Ani5zvGRrb0gIeQ==
X-Gm-Gg: AfdE7clGJ7V25+G+b/y0+iZh6r4P08PixF4ixo1NDcHP6lXsn3zS6P29r9MzT1BItaD
	8WueQfk+6XWq61HMrJczGowKf8nJh3gfsIdcwKaWWs7c74aIlnfTecrs0k9k16Y3z/KK2uJyOSQ
	tpqCup4/8KlpVkiloIHiHL6/5D1IDEfxb0tFS5BwfhB2/AbBkxo2Qh6Ar4qCRaiu526SXhd1gwg
	cBhkU3Bz4pg/zncr+RWiWTFipdiX8TyDX27fVqBy2tA9J2K+rH9a5M=
X-Received: by 2002:a53:ac88:0:b0:666:2480:2b0a with SMTP id 956f58d0204a3-66624802c95mr562170d50.50.1782939077541;
        Wed, 01 Jul 2026 13:51:17 -0700 (PDT)
X-Received: by 2002:a53:ac88:0:b0:666:2480:2b0a with SMTP id
 956f58d0204a3-66624802c95mr562129d50.50.1782939077080; Wed, 01 Jul 2026
 13:51:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Andreas Gruenbacher <agruenba@redhat.com>
Date: Wed, 1 Jul 2026 22:51:06 +0200
X-Gm-Features: AVVi8CfsV3cGOgb6Svx2JkIRUFiPC3HXmSBXTyt1juuiIVniLQt7WCc-miACenM
Message-ID: <CAHc6FU4tz8-HmEf2_XKT0NT8N=rv5OMcY79PxTACkXAVLOAUpg@mail.gmail.com>
Subject: iomap_writepages WARN_ON_ONCE(PF_MEMALLOC)
To: Christoph Hellwig <hch@infradead.org>
Cc: Christian Brauner <brauner@kernel.org>, "Darrick J. Wong" <djwong@kernel.org>, gfs2 <gfs2@lists.linux.dev>, 
	linux-xfs@vger.kernel.org, linux-fsdevel <linux-fsdevel@vger.kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

Hi Christoph,

I'm running into a problem with the following check in
iomap_writepages() on gfs2 in RHEL-8:

        /*
         * Writeback from reclaim context should never happen except in the case
         * of a VM regression so warn about it and refuse to write the data.
         */
        if (WARN_ON_ONCE((current->flags & (PF_MEMALLOC | PF_KSWAPD)) ==
                        PF_MEMALLOC))
                return -EIO;

In my case, reclaim is triggered by the following command:

  echo anything > /sys/fs/cgroup/memory/.../memory.force_empty

And we end up on this code path:

mem_cgroup_force_empty_write -> mem_cgroup_force_empty ->
try_to_free_mem_cgroup_pages -> do_try_to_free_pages ->
shrink_zones -> shrink_node -> shrink_node_memcgs -> shrink_slab ->
do_shrink_slab -> super_cache_scan -> prune_icache_sb -> dispose_list ->
evict -> gfs2_evict_inode -> evict_linked_inode -> gfs2_log_flush ->
gfs2_ordered_write -> filemap_fdatawrite -> __filemap_fdatawrite ->
__filemap_fdatawrite_range -> do_writepages -> gfs2_writepages ->
iomap_writepages

The PF_MEMALLOC flag is set in try_to_free_mem_cgroup_pages() before
calling do_try_to_free_pages(). We end up in gfs2_evict_inode(), and
the filesystem is required to evict the inode. At that point, gfs2 has
no way of recovering from an -EIO error from iomap_writepages().

That WARN_ON_ONCE() was originally added to xfs in commit 070ecdca54dd
("xfs: skip writeback from reclaim context") and later modified to
allow kswapd writerback in commit d4f7a5cbd544 ("xfs: allow writeback
from kswapd").

Before commit c2dc7e5589a1 ("iomap: move the PF_MEMALLOC check to
iomap_writepages"), the comment above the WARN_ON_ONCE() indicated
that the reason for rejecting the write was to prevent stack
overflows. But this code path triggers reclaim right at the top of the
stack, so that's certainly not an issue here.

Do you have any suggestions?

The above is on RHEL-8, but a similar code path exists in cgroups v2,
triggered via:

  echo reclaim_amount > /sys/fs/cgroup/.../memory.reclaim

That code path starts with:

memory_reclaim -> user_proactive_reclaim -> try_to_free_mem_cgroup_pages ->

Thanks,
Andreas

