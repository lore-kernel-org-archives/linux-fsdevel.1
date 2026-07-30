Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E479339DBD7
	for <linux-fsdevel@vger.kernel.org>; Thu, 30 Jul 2026 13:49:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785419365; cv=none; b=sNLIRPBRU2lcbGRPAKTwcTxP+GaZL8eTqQi2VbEavwjMhUIT13kGrvBwoYNHKfm5S+6VpssxIHaax4cukiUPrl7PHvU1xcyNcbXyIXNf2zHLqDRMU+xnJXXNNLL+YYf32tgc4i8iK/SK1TWqEGXmiA0uUZTURnbyIDFlZRuEyx4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785419365; c=relaxed/simple;
	bh=8qwv5PHUKAWevhYZKKooQP58IC17+6pzYZvIcyxMNQs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=rBSmXX7EUu9WW94ZPz1ezh3arj5XJnrUPlPeLivj1jHPz20NNdYLlZP8tJoOg1ufi5adQGZW4Hx0CntMIiNVkkyn93C0Y3EI1ateWEL1JAKMG5RuGK4B5XmhdJV9PkFpuSsdNvL3AwTYLN5LbW3vEsqFrmqt8sfQWTJcW6jazXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ICnlsd1A; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ICnlsd1A"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1785419362;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=b4EqHffQZ+7yOTPccLs7D+jOVNUfFcke1CghDWdjZE8=;
	b=ICnlsd1ANoYDPAYXLOzZwj633o3Cr6KUI9w/1rJiY1W3TLPAvwcJDIMraUeKKbCQ8c15m5
	UZrMapZqQ1+EcJw77Qpwsb+baHUxfdvySyPhtjAXpysYhPGZekiA5IXtHnXrDxiL8hqxl7
	kuq9/Vaxvqc61mcQ5WFYo5CaHLFsDpA=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-638-shRJlmpBPsm3LdaYnEvU1Q-1; Thu,
 30 Jul 2026 09:49:19 -0400
X-MC-Unique: shRJlmpBPsm3LdaYnEvU1Q-1
X-Mimecast-MFC-AGG-ID: shRJlmpBPsm3LdaYnEvU1Q_1785419357
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id E1561195608D;
	Thu, 30 Jul 2026 13:49:16 +0000 (UTC)
Received: from localhost (unknown [10.44.49.125])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 390E11956089;
	Thu, 30 Jul 2026 13:49:15 +0000 (UTC)
From: Giuseppe Scrivano <gscrivan@redhat.com>
To: Pedro Falcato <pfalcato@suse.de>
Cc: linux-erofs@lists.ozlabs.org,  xiang@kernel.org,
  linux-fsdevel@vger.kernel.org,  amir73il@gmail.com
Subject: Re: [PATCH] erofs: reuse superblock for file-backed mounts
In-Reply-To: <amtJX8aTZT5d_sP3@pedro-suse.lan> (Pedro Falcato's message of
	"Thu, 30 Jul 2026 13:57:29 +0100")
References: <20260730124120.1501126-1-gscrivan@redhat.com>
	<amtJX8aTZT5d_sP3@pedro-suse.lan>
Date: Thu, 30 Jul 2026 15:49:14 +0200
Message-ID: <8733x0k2p1.fsf@redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

Pedro Falcato <pfalcato@suse.de> writes:

> On Thu, Jul 30, 2026 at 02:41:20PM +0200, Giuseppe Scrivano wrote:
>> When the same file is mounted multiple times (via path or fd), reuse
>> the existing superblock instead of creating a new one.  This allows
>> multiple mounts of the same image to share in-kernel data structures
>> more efficiently.
>> 
>> The backing file is identified by its inode and fsoffset.  If mount
>> options conflict, a separate superblock is created transparently as
>> a fallback.
>> 
>> Tested by mounting a 177M Fedora EROFS image 20 times with full
>> traversal:
>> 
>> ```
>> \#!/bin/sh
>> IMG=${1:-/root/fedora.erofs}
>> N=20
>> DIR=$(mktemp -d)
>> trap "umount $DIR/m* 2>/dev/null; rm -rf $DIR" EXIT
>> 
>> sync; echo 3 > /proc/sys/vm/drop_caches
>> INODES_BEFORE=$(grep erofs_inode /proc/slabinfo | awk '{print $2}')
>> MEM_BEFORE=$(grep ^Slab: /proc/meminfo | awk '{print $2}')
>> 
>> for i in $(seq 1 $N); do mkdir $DIR/m$i && mount -t erofs "$IMG"
>> $DIR/m$i && find $DIR/m$i > /dev/null; done
>> 
>> echo "Superblocks: $(grep $DIR /proc/self/mountinfo | awk '{print $3}' | sort -u | wc -l)"
>> echo "erofs_inode delta: +$(( $(grep erofs_inode /proc/slabinfo | awk '{print $2}') - INODES_BEFORE ))"
>> echo "Slab delta: +$(( $(grep ^Slab: /proc/meminfo | awk '{print $2}') - MEM_BEFORE )) kB"
>> ```
>> 
>> unpatched kernel:
>> 
>> Superblocks: 20
>> erofs_inode delta: +46368
>> Slab delta: +39952 kB
>> 0.08user 0.82system 0:00.98elapsed 93%CPU (0avgtext+0avgdata 4796maxresident)k
>> 19168inputs+10304outputs (24major+16672minor)pagefaults 0swaps
>> 
>> patched kernel:
>> 
>> Superblocks: 1
>> erofs_inode delta: +2044
>> Slab delta: +1088 kB
>> 0.07user 0.21system 0:00.31elapsed 91%CPU (0avgtext+0avgdata 4848maxresident)k
>> 19024inputs+6784outputs (25major+16810minor)pagefaults 0swaps
>> 
>> The time difference shows that sharing the superblock also benefits
>> the page cache and inode cache, as subsequent mounts of the same image
>> avoid re-reading the backing file.  This is particularly useful for
>> container hosts running multiple containers from the same base image.
>
> Doesn't this approach break-down as soon as you get to change SB flags (through
> e.g mount -o remount)? It will change superblock flags for all of them, right?
>
> (I don't think you can switch off the superblock transparently on a
> reconfigure?)

This is the same preexisting behavior for block device mounts.  That
said, I realize this can feel confusing since EROFS is not a block
device and allowed this so far.

One way to solve this could be an explicit mount option "share_sb" that
is opt-in and, once set, blocks any remount operations.  Would that
work?

Regards,
Giuseppe

