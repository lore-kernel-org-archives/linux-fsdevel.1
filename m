Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B30B64119F2
	for <linux-fsdevel@vger.kernel.org>; Thu, 30 Jul 2026 12:57:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785416263; cv=none; b=U6z/EiUccD/MA3R6iOsA8HwaN7WbSu3mxvQOqcsE00D8CxxPo3kDJxXxSI2kocBkZQDXOUodAbjGHy7RFHT1BWEY8MNxbDxX9vAnPeWVOPtah3oVcueK6Z4aBvOZbgePuDzwSu3haOn5Vexu/z+WHETEDc9nOwcpnSENVwFXaHQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785416263; c=relaxed/simple;
	bh=9BYMCdV/NkivgDq5tMWeis7+JvH/36dj0z8nv+SdrGk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L2ZcAh1qg/I7s1tlf13T823aF+ZPwElsblQjkkqtt7C3h4hWr7YwSUIeYrnRck55fcC3qGCverOHjgAEQFgCcJJ5Eox5Wc+6Mtk3/BjDFsZ3rL395MmSZ96iKp3fj7A5aNu6jveWZ9FMHJRB3VXR5HK0IYIuAIjVqTL9zsAk1vo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=FTri4Jig; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=bzyMWEu4; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=bgtA4+tV; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=MgkMvlOy; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="FTri4Jig";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="bzyMWEu4";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="bgtA4+tV";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="MgkMvlOy"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 9D6A7406B;
	Thu, 30 Jul 2026 12:57:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1785416255; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Ctvgo/EqWQo4e0rwb2R8s7WVtY+eCNnEEpS2X3TZXeA=;
	b=FTri4Jig1HSSgxuILytj6EgJsYe+hrMu7pzHEx4Zzc1trkEUU8XsblApdGFwIJDnSgov2Z
	D0Ziv5sRN43NswhbCZDDJ8XEXjyjAgJltWLdxjO8Cnxgrrewnl2euEqJqb9/ddl2NnmXo2
	VY7iLdfazPqvE+UO9jkSnGuzbyg26pk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1785416255;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Ctvgo/EqWQo4e0rwb2R8s7WVtY+eCNnEEpS2X3TZXeA=;
	b=bzyMWEu44QtuIoSPtxXcr1GNrB/rUiPrEq3+F32YuwWzTrlxGNi3ndiPDdmZAE/wY0Y2q9
	qz3AzVOO6nYqr8Aw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1785416251; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Ctvgo/EqWQo4e0rwb2R8s7WVtY+eCNnEEpS2X3TZXeA=;
	b=bgtA4+tVKB67BHAYuhURaoYWRKAJb77KxIt8vHk08J+79lbXGLW3VD8zZsjoGOFvHZcoaM
	S72dhFOviJEaOUJL/yMzoSIhIc7fVimImOjz1Se2kpm0XU6A2u6y8NqT4f+i7h/b+m9p7d
	FAv/apcDYBvsz1H6MAr6oHKM+RWat4o=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1785416251;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Ctvgo/EqWQo4e0rwb2R8s7WVtY+eCNnEEpS2X3TZXeA=;
	b=MgkMvlOykjNmJWdYuFQcYwo7WU3oVBMDMLfXI9OruV4L3MknavKjBTrnPI9kIyZHTPf3BX
	7xKDhr7N82YeMQAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 3621F779CC;
	Thu, 30 Jul 2026 12:57:31 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id SonoCTtKa2p/RQAAD6G6ig
	(envelope-from <pfalcato@suse.de>); Thu, 30 Jul 2026 12:57:31 +0000
Date: Thu, 30 Jul 2026 13:57:29 +0100
From: Pedro Falcato <pfalcato@suse.de>
To: Giuseppe Scrivano <gscrivan@redhat.com>
Cc: linux-erofs@lists.ozlabs.org, xiang@kernel.org, 
	linux-fsdevel@vger.kernel.org, amir73il@gmail.com
Subject: Re: [PATCH] erofs: reuse superblock for file-backed mounts
Message-ID: <amtJX8aTZT5d_sP3@pedro-suse.lan>
References: <20260730124120.1501126-1-gscrivan@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260730124120.1501126-1-gscrivan@redhat.com>
X-Spam-Score: -4.30
X-Spam-Level: 
X-Spam-Flag: NO
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	ARC_NA(0.00)[];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[lists.ozlabs.org,kernel.org,vger.kernel.org,gmail.com];
	RCPT_COUNT_FIVE(0.00)[5];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo]

On Thu, Jul 30, 2026 at 02:41:20PM +0200, Giuseppe Scrivano wrote:
> When the same file is mounted multiple times (via path or fd), reuse
> the existing superblock instead of creating a new one.  This allows
> multiple mounts of the same image to share in-kernel data structures
> more efficiently.
> 
> The backing file is identified by its inode and fsoffset.  If mount
> options conflict, a separate superblock is created transparently as
> a fallback.
> 
> Tested by mounting a 177M Fedora EROFS image 20 times with full
> traversal:
> 
> ```
> \#!/bin/sh
> IMG=${1:-/root/fedora.erofs}
> N=20
> DIR=$(mktemp -d)
> trap "umount $DIR/m* 2>/dev/null; rm -rf $DIR" EXIT
> 
> sync; echo 3 > /proc/sys/vm/drop_caches
> INODES_BEFORE=$(grep erofs_inode /proc/slabinfo | awk '{print $2}')
> MEM_BEFORE=$(grep ^Slab: /proc/meminfo | awk '{print $2}')
> 
> for i in $(seq 1 $N); do mkdir $DIR/m$i && mount -t erofs "$IMG" $DIR/m$i && find $DIR/m$i > /dev/null; done
> 
> echo "Superblocks: $(grep $DIR /proc/self/mountinfo | awk '{print $3}' | sort -u | wc -l)"
> echo "erofs_inode delta: +$(( $(grep erofs_inode /proc/slabinfo | awk '{print $2}') - INODES_BEFORE ))"
> echo "Slab delta: +$(( $(grep ^Slab: /proc/meminfo | awk '{print $2}') - MEM_BEFORE )) kB"
> ```
> 
> unpatched kernel:
> 
> Superblocks: 20
> erofs_inode delta: +46368
> Slab delta: +39952 kB
> 0.08user 0.82system 0:00.98elapsed 93%CPU (0avgtext+0avgdata 4796maxresident)k
> 19168inputs+10304outputs (24major+16672minor)pagefaults 0swaps
> 
> patched kernel:
> 
> Superblocks: 1
> erofs_inode delta: +2044
> Slab delta: +1088 kB
> 0.07user 0.21system 0:00.31elapsed 91%CPU (0avgtext+0avgdata 4848maxresident)k
> 19024inputs+6784outputs (25major+16810minor)pagefaults 0swaps
> 
> The time difference shows that sharing the superblock also benefits
> the page cache and inode cache, as subsequent mounts of the same image
> avoid re-reading the backing file.  This is particularly useful for
> container hosts running multiple containers from the same base image.

Doesn't this approach break-down as soon as you get to change SB flags (through
e.g mount -o remount)? It will change superblock flags for all of them, right?

(I don't think you can switch off the superblock transparently on a
reconfigure?)


-- 
Pedro
