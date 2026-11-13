Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.177
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794598872;
	b=w7MqPk9bsiDx0jp6+JxAaoiBnB61rcSjvTiUeEoJ5McktVF3nv4MeXCmimQwJ2nQ/hdZ
	 Ytl439Mi2gDhsZZsqeenKFDO1gXQ92n7HBBiyr63eFxs+AkdsLaYpKgEtPGA6p6gYCccA
	 Xd6x5Tl9wBDcNcHG4pjLkIhO1rlaR1VDqzDT+JM6OEtmEBjNtWAE+J1M57ZbSj9axUulG
	 oNnUuIaWl2N8BK8bm3Oil87RMjzvoAHs1SHLT1M4946MZMphPU7s3zzzGxPh8S1gZxfzF
	 3AhXSYuoKyqUmPMy4RbA0l4XF47cb7/611J1PWB+EBgtZLAvSov20azLj72tKPY5kXQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794598872;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=rFhcFK7/zd+xhQ8fW4dOWf9BdumBCXdBWAPxNYD5E5Y=;
	b=QwaMXLms90UdD6n5Zgz9p1Bgrx+PVpV6rEka5d6NsN5UCWXFHm2ho3xd5cBerw6vFvPl
	 /vOK281Kxg85laV/cIThpqHxzFFgdFi+U6bjGRImleWjTWzk9fHT/ilVWebTRrPBzaHoK
	 mg93jVna+lYlnDU9tPYAmAr3Xl83vlw7qZSeX9zd20KIjAl3YBLrFMPNjHCskknYCaNFw
	 8H+6xfFkaOfnAGack8MMMjQ8+qPMYRffVyukth2ITlLgeJR8hrk3QnRIKc4d07PSJfjAy
	 eFozc9AHneufT9B3CNxQfDprqdhOrsmtO+QZ9i4GIrIenTKiubCgojCtCiB5Afc02tQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=cs.unc.edu;
	spf=pass smtp.mailfrom=cs.unc.edu;
	dkim=pass header.d=cs.unc.edu header.i=@cs.unc.edu header.a=rsa-sha256 header.s=google header.b="ZNHrF2/h";
	arc=none smtp.remote-ip=209.85.160.177
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D867606A333
	for <linux-fsdevel@vger.kernel.org>; Fri, 13 Nov 2026 19:41:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9D867606A333
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cs.unc.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cs.unc.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cs.unc.edu header.i=@cs.unc.edu header.a=rsa-sha256 header.s=google header.b=ZNHrF2/h
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-55c4e670fc6so572971cf.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 13 Nov 2026 11:41:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cs.unc.edu; s=google; t=1794598870; x=1795203670; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=rFhcFK7/zd+xhQ8fW4dOWf9BdumBCXdBWAPxNYD5E5Y=;
        b=ZNHrF2/haGgJJ3YhZJtarvMKEvQx992AcLULsAKI8Ew+keAp509JP1ZAhWWO7Tw5Fa
         5kgsE+Z/yJGjcts8r4id75BFZJuN23UiqJcYJ0O7/Am/2cbsvCJQ0Vk8XkixgxJqw5PU
         RHlUt5M2zEwTub1ZMmxc8DHijjCtvvNbv2N/8PaW3PUbZScGsxJ7nOeDPYZN68I7xnvB
         Edqxo9TiSZIph+AhheKn+DZdxAUMwM3tuC61hgclKxYExc7K6/azt4ouWpTGimsSTXmb
         40egRRu58OS5SaQK142lucoWy8QbkbVYDMpoo2ye3R4/OVMWxXLvJZRTmq5nPlMAF+Ei
         /0lA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794598870; x=1795203670;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=rFhcFK7/zd+xhQ8fW4dOWf9BdumBCXdBWAPxNYD5E5Y=;
        b=V7oR1qp6RndmB5AvWMSzwCdZL63lCjITxjQIZW0X/CnSXhQuVwXlxP1BZUYRprDUud
         9ORD9KWA96508mbdEFwPeaLq4yLmVSp79B6Oe+AkoeOwMV7MwHxqHlEVez5bA1FakrJQ
         NXkUvHkDOIVKiGIafPA3U677zBYC0TI+vQIPn/p1xC4bJnbcf96DTBpyyrysvm0gf8o/
         /rIWLkuiNTqolJ2A8KpIalhGrkNw2iXyS7mtOlqIpbqw7rMUc4vSt5B16qQ5uZ+W9rsd
         0+jXii+BG/EYvAeqC4YpkVZ/JX9w6ZAkqO8jJdTGIKcfQV4+e1oF+tXC6BxmiccE2Xfo
         mhHg==
X-Forwarded-Encrypted: i=1; AL+hErE6Re1wXc5BVdHPnQsH+URyWbPHZkBjKlAovHrAG616pTFRvbq+g8ih+VMhtxysUcqaloTqoSs5CXjbpY3Q@vger.kernel.org
X-Gm-Message-State: APuU4Z/qGLia+oJHAT5cggGihuUOWWcseOdeA0RWGNHoVmueG5onnCkJ
	2pKRtSgHXrQWve92NV8/oKBtG2w6fHdWcZ26AmaEhnzau4rnldg5pv+wcbgZuh/5xw==
X-Gm-Gg: AYBFou0DoBaOAQg1NGmaiyTF3TqBn9NtGF1WxICbK106RWguB2tIRiwzcJisWP9FDW3
	VUD8jmFV8rlgHdUm8FaRJv9fsQYcw8oNxLJyPOOukSj33eZEmDrpSwvVHNAqGTlEfbOMI0opYlP
	YlkOWjSGlH1Ho7hIH7ycm+w0yT8MI/5o6Jn2DwklKUAeLOARRLtT/2I57drN6todoxd6roQ9ygn
	jIyCR2yb7zhRL2U8k6rrF4PWopADRlc8X4inGJhpsCI7YSLF3FYRa79VrFnoPl7lTa+dpbfhT67
	IsXV3SjXeDQ7YhHXr35+bNNJmVH/inyxkCDDN4XuPJrrn9A3mlsbq+qATp+NraL3aFtGatCzzVW
	ObRCEUkB4O/yB11NXI4c9pGqfEPLYmIEFYsdwSqYoZga1/ZS8Z2YzpwcHTBGFlHqV7mImZPiyd7
	xAEeUpFmAzUxSXetGemanUahjGayFPYc4Gp/WoVUOqwp6IO6J1jl1xp9o5bskUIT16ls/O2vN8D
	G4bxOvP6tRPPEugasoJ9mCZTkmwl8fMIyEoe6PSJARbYld+Tbjllf8S3yJqxM9fGeS+OoS6RSaX
	SRt3YWxS8CaDtmca7Dxs9+664ANZbZPciyBXBhNQIU9gy1pkl05uGCLT8boBbAGeYqK0ZRt0ew=
	=
X-Received: by 2002:a05:622a:4005:b0:535:384d:68ac with SMTP id d75a77b69052e-55ac6c7bc64mr53336161cf.13.1794598870411;
        Fri, 13 Nov 2026 11:41:10 -0800 (PST)
Received: from cobra01.cs.unc.edu (cobra01.cs.unc.edu. [152.2.130.143])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-55bd520d5a3sm9848131cf.0.2026.11.13.11.41.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2026 11:41:09 -0800 (PST)
From: Hengyu Liang <hengyul@cs.unc.edu>
To: slava@dubeyko.com
Cc: glaubitz@physik.fu-berlin.de,
	frank.li@vivo.com,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v2] hfs: avoid reusing occupied CNIDs after deletion
Date: Fri, 13 Nov 2026 14:41:03 -0500
Message-ID: <20261113194103.3825961-1-hengyul@cs.unc.edu>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2bbc10eb1dd5ee69329a9307f14fd15b1815b898.camel@dubeyko.com>
References: <20261112110128.4082071-1-hengyul@cs.unc.edu> <2bbc10eb1dd5ee69329a9307f14fd15b1815b898.camel@dubeyko.com>
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Slava,

On Thu, 2026-11-12 at 14:34 -0800, Viacheslav Dubeyko wrote:
> I am still not sure that this approach could work. If we haven't the
> thread records in the b-tree, then we sort records by parent CNID. But
> folder can contain child with any CNID. So, if we keep the largest CNID
> in use, then, technically speaking largest CNID - 1 can be located at
> any node (it doesn't matter if it is used or not). Even if we found
> node #1 with largest CNID, then it doesn't mean that largest CNID - 1
> is located at the same node #1. And even if we cannot find the largest
> CNID - 1 value, then it doesn't mean that this value hasn't been
> allocated already as child CNID of some parent CNID (because records
> are ordered by parent CNID). Are you sure that this approach will
> finally work?

Yes. The patch never searches for a CNID, neither the largest one nor
largest - 1. It only needs the maximum of the CNIDs of all file and
directory records, and a maximum does not depend on the order of the
records:

- max_cnid of a leaf node is the largest DirID / FlNum of its file and
  directory records. The CNID is read from the record data, not from
  the key, so the parent ID and the thread records do not matter.
- max_cnid of an index node is the largest max_cnid of its children.

So the root holds the largest CNID in use, wherever the records are.
When the record with the largest CNID is removed, only the nodes on the
path from its leaf to the root are computed again; every other node
keeps its value. For example:

              root: 20
             /        \
     leaf A: 19      leaf B: 20
     (16, 19, 17)    (20, 18)

  rm 20: leaf B -> 18, root = max(19, 18) = 19, next_id = 20
  rm 19: leaf A -> 17, root = max(17, 18) = 18, next_id = 19

Both times largest - 1 was in the other leaf, and it was counted because
that leaf keeps its own maximum.

next_id is then set to max + 1. Every CNID in use is <= max, so max + 1
is free. Deleted CNIDs below max are never reused, so we never need to
know which CNIDs are free. A red-black tree of deleted CNIDs would only
be needed to reuse those holes.

To check it, a debug build compared every cached max_cnid with the
value computed from the records after each catalog insert and remove:
about 88,000 full-tree checks on 2,000 files with random operations and
4 writers, plus a run under memory pressure that freed 55,630 nodes and
read them again. There was no mismatch.

> Why do we need this flag? If node is created, then it should have valid
> max_cnid.

max_cnid is not on disk, so a node that hfs_bnode_find() has just read
does not have it. For a leaf node it could be computed from that node
alone, but for an index node it needs every node below it. Computing it
at read time would read the whole catalog at mount, and again for an
index node that hfs_release_folio() freed and that is read again later.

The flag means "max_cnid of this node has been computed".
hfs_btree_max_cnid() computes only the nodes without it, and only when
the newest file or directory is deleted. The first such delete after
mount still reads the whole catalog once; later ones only recompute the
nodes on the path of the removed record. The flag is also cleared when
the largest CNID of a node is removed, and on a split, because records
move to the new node.

Thanks,
Hengyu
