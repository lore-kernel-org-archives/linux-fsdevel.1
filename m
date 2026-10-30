Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.181
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793329034;
	b=3oB2zfDf1eRq5IQlwxPGcrdJij5iDWl/E95f6w4Pi8MDgu7QKNrjUeWnxokE7edD4Ch8
	 zTKfkqO6j9YV+noHX6uldpdJ6Nhx3vQUwV/Dq1dYQFS55Nhw+7BEkEeJY3ggS4NAo5ODR
	 sO/DBFSern/TgqsmsYX5782UjV/1QbLBGQGEen37Q1COM5rJwzc9sjJdGgBj6PgA2yC+v
	 Wx/pLQokJJMouth0pw2oPp19ExKzUrOID78XKwK9yoA3BiA5m30/XtVm3wUpOjv/BjWFC
	 Uq/WfIrvxqNzMLhwEuMnM5ZorzA3tLeNjW0FSz7k6RzwOt78hTvihCFwKo1179kwq1Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793329034;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:Content-Transfer-Encoding:
	 In-Reply-To;
	bh=/ZdXC9RaNc34pyVI5ALRxFES86jLTzutVsfPjdP/KMA=;
	b=4DPx5nHhm/hL202Clp/jRbMYkxC601sm9YX+aB36gtVmH7GOgowZDPs14ssz/D4I2VWF
	 B1C8WPB+PR61EVN52weLvKp6DusuSve6dfzoTdB40P3kakN13uIGi90re+kcB19cUD00N
	 RnWTLDWVtnONWmG0ZFwt4hM3csEb165FuBmDUDOJVw6GQ/icrlNlRhPB6tmTK3MsyBo02
	 Tkt8WLijZe+yAI2nn2JywSwlTieeT7ZASHpbnEhQhmM+Q53Vd9GOPtLls/28PYgtjMnAH
	 aJE2bbOAyYmaYFe0pOl+Zzl12o2zMQeQU3+G4qIqkZAcOKj2Ctklfo/hxPl5lkiA/eg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="mCvEF/B0";
	arc=none smtp.remote-ip=209.85.210.181
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71748606A31A
	for <linux-fsdevel@vger.kernel.org>; Fri, 30 Oct 2026 02:57:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 71748606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=mCvEF/B0
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-8a06c60065fso95916b3a.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 29 Oct 2026 19:57:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793329034; x=1793933834; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=/ZdXC9RaNc34pyVI5ALRxFES86jLTzutVsfPjdP/KMA=;
        b=mCvEF/B0x+B4fIM/iYE4URUqrgWef4VAXimGI6qerYmN+LkM2lC00w7qib/QTR9K+x
         q8EDgBKBICHnCc3FmbAcwYG/Tr24NW0beOLrPAIAuhvf6gRTt959p2G2o0ya9TgSBY4P
         lg8942Gku5CIXn5oyE0+a1T6rmsFcJR/zqf9T4MTsND/pXISxluBRn1bZemCja3/B9xB
         eEB9pOr6KeAozcL+PVhrlqO4upaRtvFRBBOnTOOABAfVJ9uB6HbdnF6mDjICro3ysOHc
         xQdeWUG1hAdFrw+eX+ckjPQrlxeE4b4fQHUjwJz/sG4pib0SoAGI8zPS9fu2RK8eZUQp
         lEHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793329034; x=1793933834;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=/ZdXC9RaNc34pyVI5ALRxFES86jLTzutVsfPjdP/KMA=;
        b=ZGKG+Vvj9iz0jc7ORzOvEKQj3y2dK3aqT24uYQh5yKT1LTGXvFrmLgtEye2eaM/Ja1
         T6tZlRSLYWnEYmolsIuzQf56i0kwuS8/KXCu+6bMhrj4a4achwDVH+zIUr6RwlGuQuRk
         IqwPxYv8k3txjMguE5irLy0RdMeYaBnCVVEoItrnY70xspFjYXJ0xiFAU4rgL6mIsoUt
         UjKsNo1BSBSIpqiryL9YNdD9eFqYBxIfUk+ozzvKNQgWhf7LZOizp358VeGnDYh/Dd7W
         AnXxapUDguAxS3yJxIOHp+pX5R0bdbjCwocFcl7AtbSGsprnB3ewS8ARYdWEGWqZxEG1
         TQhw==
X-Forwarded-Encrypted: i=1; AKwUvBz4uHG5Ayi5NpU0BxvFZAVurUMS4v2jlLZsqoRYa7Oa519qQpaYMnDd6x3hYzBna+p8wvhsZoYHdAVzyrWd@vger.kernel.org
X-Gm-Message-State: AFq9FYIxWzxWwlnuIuUsjUJUnAu+GJvuNDB1nEjD3EicSOUdet/grgv5
	cKRZpyC+zuQVXH83ui8OEvoP3UZisXKAW1UcJY/7QuevKUsYYJ5fUymu
X-Gm-Gg: AYBFou3S7p5GYaZuPvXSQgkgxd8owQazC6QdY8A87CB/4EC+TDG/BXawS4XBY4JBcV/
	xg16TqcZlwj43DW3sP+y6aBQ3uWHVfBPup3vLwxoIEaOXb4pQ98oS1sU+OPdPeSGRjESiPBThjM
	LTHIMKuBuoxTktCcWy+9qngR+aVccKB8rJuboXI+JQLOr3cCjUdFQbZt3UcwYXOJ49GB5KbY98V
	3jsKU5OZmDJosqaE1+zd44AyhQA53ODh43/AKIgzjj1zJY7xMHS9jGL/Fr/DjgwPBlKPqzw5g6Y
	2ycxhFTh37WKg03gI0zM5QebuTGFRsb2SQkTd+//MPt1cqWJ0h/E+9qcVm5RuSU5ooOjXYIN6DN
	xP3FlNavUHJ6JTn+nSdGnXoWaLCiiPQ+dbh/swQL4xwyFXGi3YUronbXj6flOTZyDJ6l72QeQTK
	JwnqbnCV0LCoI8d/hASEAObNyqlmO8Fg3TSsjf0FAGYh+UzYjRTJK31g5oNlgHX8W3ITh/EtkZW
	zbfFgYCMwSm/USeeM9PDxYNRAghA8LpKa5K4/GSfBlXdVYHZvGENjrYl3rd0XIpTo2A2qJBtMuB
	51aqBRZpKmOxmRj1mCWxwWt9W0GUN3ILBacCrPY8
X-Received: by 2002:a05:6a00:290f:b0:8a3:df84:4c14 with SMTP id d2e1a72fcca58-8a9bee525bbmr794496b3a.57.1793329033656;
        Thu, 29 Oct 2026 19:57:13 -0700 (PDT)
Received: from localhost ([27.122.242.71])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8a9eef95cb5sm162643b3a.9.2026.10.29.19.57.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Oct 2026 19:57:12 -0700 (PDT)
Date: Fri, 30 Oct 2026 11:57:10 +0900
From: Hyunchul Lee <hyc.lee@gmail.com>
To: Shengzhuo Wei <me@cherr.cc>
Cc: liubaolin <liubaolin12138@163.com>, Namjae Jeon <linkinjeon@kernel.org>,
	ntfs@lists.linux.dev, linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] ntfs: wait for bitmap folio writeback before modifying it
Message-ID: <auQHhmnBbntRem3o@hyunchul-PC02>
References: <20261029-b4-ntfs-bitmap-writeback-wait-v1-1-e2ba711b2dbf@cherr.cc>
 <374bf856-f880-4fa2-abec-c4b2a063bf57@163.com>
 <auLlFEHMZvANXUvU@kernel>
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <auLlFEHMZvANXUvU@kernel>

Hi Shengzhuo,

On Thu, Oct 29, 2026 at 02:17:56PM +0800, Shengzhuo Wei wrote:
> On 2026-10-29 10:07, liubaolin wrote:
>  
> > Hi Shengzhuo,
> >    Could this deadlock during MFT bitmap
> > expansion？ntfs_mft_bitmap_extend_allocation_nolock() can recurse into MFT
> > record allocation while holding mftbmp_ni->runlist.lock.
> > 
> >   With L being that lock, could we get the following interleaving?
> > A and B are $MFT::$BITMAP folios; B is outside the cached iomap.
> > Time flows downwards.
> > 
> >   Writeback                        Bitmap expansion
> >   ---------                        ----------------
> >   lock A
> >   set PG_writeback(A)
> >   map A (take/release L)
> >   add A to wpc->wb_ctx
> >   unlock A
> >   [BIO still unsubmitted]
> >                                    take L
> >                                    extend bitmap mapping pairs
> >                                    need another extent record
> >                                    ntfs_mft_record_alloc()
> >                                      mft_bitmap_alloc_free_rec()
> >                                        lock A
> >                                        folio_wait_writeback(A)
> >                                    [wait for A's I/O, holding L]
> > 
> >   lock B
> >   set PG_writeback(B)
> >   ntfs_writeback_range(B)
> >     __ntfs_write_iomap_begin()
> >       down_write(L)
> >       [blocked on L]
> > 
> >   Cannot reach iomap_add_to_ioend()
> >   to submit A's pending BIO.        Cannot release L until
> >                                    A's writeback completes.
> > 
> >    ntfs_writeback_range() obtains the next mapping before
> > iomap_add_to_ioend() can submit the pending BIO.
> >    Would we need to submit that BIO before taking the mapping locks?
> > 
> > Thanks,
> > Baolin.
> > 
> 
> Hi Baolin,
> 
> Thanks for the analysis. I checked the paths and agree with you.
> 
> Following your suggestion, I prepared a change to submit the pending
> ioend before obtaining a new mapping in ntfs_writeback_range(), clearing
> wpc->wb_ctx even on error to avoid resubmission. I plan to make this a
> prerequisite for v2, retaining all six waits.
> 
> One concern is that submitting at mapping boundaries may reduce BIO
> aggregation, including for ordinary file writeback. The change has
> passed object builds, but has not been runtime- or performance-tested.
> 
> Does this approach look reasonable to you?

I think the early submit should be limited to $MFT:$BITMAP only.

> 
> Thanks,
> Shengzhuo

-- 
Thanks,
Hyunchul
