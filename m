Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.180
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795472858;
	b=Y+4yC8kbHUQo5vF8sWlbNqA0MzuuCogD3CdMDtB+HGY8V5WYQ3onuTkzPzMweQuNBfCG
	 cY4R4pC+O/xjkxGvwi6Ejv8kgn/HkWyL2/zLTs1+9ejwYohUp0hbUGzsMOqrGTCofoNyT
	 l81rVtM65ZTyh/Y1CmUwHz9BV4FIClYUenh2KxJL7qDDPMSIOsHfIOamr6yGedQVA8fyo
	 Mf8bdPtUUM3HZ7QLKISImCWZXR2NBD0noCDRrp1Mk86ydjh9FY5az8hoaHBzR6pwCJKnh
	 sG1I1gDOs/VEdriGWROwhXOZk3wkHEM+0z1dDv0tLaOwB0F3amEmhZAGSV70oYgfDQQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795472858;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Subject:
	 From:To:Cc:Date:In-Reply-To:References:Autocrypt:Content-Type:
	 Content-Transfer-Encoding:User-Agent:MIME-Version;
	bh=b7qQ9lbizvdrD5tIAAtT+wq73TxyjOqbhSOwF4Nb4EA=;
	b=Yw5BTk8Gkc1ELoe8nl0RayS2fZP1JN+4HyKHryM0/aliHTFZ9iB8vY5U1QCM8B1BC2ME
	 +UVJR+HhPsP7XkI1gqttHnGxWyoK99Rvo6vn9izGWTEkCD48/B19uB6xJK73I5D8Kdir4
	 U78HimrTe2+r3AeqiJiI6LhSvgtes6kRcCs3wxAb67sE1wR/f2j5XoehxcE+AYenBb9ao
	 ejsff6xFb4TPQSpTqQNpkUvlehrbq0trPuldd/ch2906z9FmlocNrAkQW38erPZK2V6HZ
	 n/4x5IMc7hqgSLhg1mImnXGqj2I6GrT0h4Fk8OrMOZj7ess+8WmzpgPprdaf5mwybYQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=dubeyko.com;
	spf=pass smtp.mailfrom=dubeyko.com;
	dkim=pass header.d=dubeyko-com.20260707.gappssmtp.com header.i=@dubeyko-com.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=Ns+Z7XCH;
	arc=none smtp.remote-ip=209.85.128.180
Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52891606A326
	for <linux-fsdevel@vger.kernel.org>; Mon, 23 Nov 2026 22:27:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 52891606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dubeyko-com.20260707.gappssmtp.com header.i=@dubeyko-com.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=Ns+Z7XCH
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-8b4efdc8c20so23268007b3.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 23 Nov 2026 14:27:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dubeyko-com.20260707.gappssmtp.com; s=20260707; t=1795472857; x=1796077657; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :autocrypt:references:in-reply-to:date:cc:to:from:subject:message-id
         :from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=b7qQ9lbizvdrD5tIAAtT+wq73TxyjOqbhSOwF4Nb4EA=;
        b=Ns+Z7XCHQEc1VwaFhiGIQBArfSp9nO0Rw16D/MDphvU9RRCeg2kExQwu0/DMMgZj6x
         ZzZMWhKKlfLkI0B1hlyEvGdBHmsD3bC5BoettnWIXmoEMEd2UZ9Gqv0+qJgPUTzVxO1O
         Qm06CG9DFWyvqQbrVZdgAglF7+Jmto4U9vfmOb0Wn+Y0YPwY6XJIUSjhrfBgcRJumOMb
         rrrRQ3JWsHJybHgPcn0qEAaD0Q+MH6Bh6L8UVum9QaiMoro1VOyt4bkBqzKImicm4Uay
         0JgK9Gs5PV+wRWIPEdcC/IzyTGxc7pS1M5c+lkCQXHItENsZlFVlO/0oC+PJlnYH1sG/
         h8Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795472857; x=1796077657;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :autocrypt:references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=b7qQ9lbizvdrD5tIAAtT+wq73TxyjOqbhSOwF4Nb4EA=;
        b=NqYWmsGxWawcOCORo/32rR1cBzNv1THnTUrueQagtNFP9uEPWaWudTjcuX2FRMx6Rq
         MOcsFtxbMNauDKwiP1rsAoL4l1kIWQurhNvq83LfXaYnU9Yd/kNrsE+IKxC1cPBN57uj
         2WbSRnzorWoWO+cvv7+3yJHm1Ao8PoixIfg2j3z3TPu9P8eB7VCiUl2BNKUByCwe6RWX
         CVgT8nF36kB3mZQKiU74ozJRdvbyeFO18DQvNxcCd7FIXBpYs9IJ6H23w9egzqZgMSwV
         v73k/u/U8k0DZc6ru1oSXBr5SLu9+O4vJBN63wo2zOk0R6//v+bd/EC6pURxoryq5X6r
         9F8g==
X-Gm-Message-State: APuU4Z9XLBef4+FHUXxUf6E4UYT2qDMfc3eypPYzPqpj0b0eOhvvwooc
	2FM3r/JvL6Ec9uY/2/d3bLgV76ZajVkx/mmQoipkTY0zMrmufP7LHk9XQP1iELkby1g=
X-Gm-Gg: AZFdTZdHBKb4KHO92CG0eT58t4VvXYbHNPSfKgc2Zi14uaqEFhpmCRtpteygh0+HDXg
	c4N1hrEbO9SGxWt+8nWE6uoHNptVUZHZ/IoVeGiTPei+uRzhgl3XeAftTMDbdcYS572mCbxeMXx
	3rV2QiLuRZLhfbDwHED6AE0tG1XDSHB9qXfU6uF+zilZASpZCKp5MUpeOZ+NW5FMKr2D4Xkl7Zf
	h1DqChWOQy/BHU3by1bWw5uT1gYEZZphn8xGPM+rdOX6YOIJDR+EVG+VNVEmp0neoIdYw8ivs5p
	L7tyc/00SbKJQq7ZFh+tEWVvWE4LXx4jLUD2Q+cmb0EDe0+hqO1G+UgqmV7qp149OqxL5bCzn61
	p8dtq1/xOb7cZ5EKl6o9oZuplmfYhVEyI7JDU9k11OW/bPUaoJNWNyAc4yCSX+hjzGlAHLIq+g+
	d8xN14ZV2Ko7POAUnFiHujgoPrId1C1aBBL05uuGH606iDyf0QamasxqM3SmS7ctLUddXJIkVr+
	8lTX8scUnEq8oJ31JiBP9ktPA+3ggrUGwtryfvWYfeO2yOyWGDi9LGmLAvTFPM/nbjv6Gg7YnNW
	cpdNpCitMvVunjGXAVu3GWtm1ngkP4d9AySfI0MjO4z987hhwpqsxZvkBU32SOBdUTWaVW7VTZc
	lN3VINNVp1tYUBPhFiAlt7Xmm9oYGCvpBPALRVO5hEQlL2GUftfaz1Epqxr7S1N8XtxZZGW+HOk
	qq/Pf4xcPAYXy27fvdOTE=
X-Received: by 2002:a05:690c:6f91:b0:8b3:1390:fc1a with SMTP id 00721157ae682-8b520319601mr50315907b3.2.1795472857366;
        Mon, 23 Nov 2026 14:27:37 -0800 (PST)
Received: from ?IPv6:2600:1700:6476:1430:83a2:1030:d4d1:10b8? ([2600:1700:6476:1430:83a2:1030:d4d1:10b8])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8b52028d8b2sm51587787b3.7.2026.11.23.14.27.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Nov 2026 14:27:36 -0800 (PST)
Message-ID: <db433a237a5ce3c093494c00fe2d8e9841928581.camel@dubeyko.com>
Subject: Re: [PATCH v5 1/5] iomap: add iomap_dio_end_io() helper
From: Viacheslav Dubeyko <slava@dubeyko.com>
To: Christian Brauner <brauner@kernel.org>, glaubitz@physik.fu-berlin.de, 
	frank.li@vivo.com, hch@lst.de
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	vdubeyko@coreweave.com, linux-xfs@vger.kernel.org, "Darrick J. Wong"
	 <djwong@kernel.org>
Date: Mon, 23 Nov 2026 14:27:35 -0800
In-Reply-To: <20261120-flach-befanden-notaufnahme-b0a663466be3@brauner>
References: <20261118004844.3849979-1-slava@dubeyko.com>
	 <20261118004844.3849979-2-slava@dubeyko.com>
	 <20261120-flach-befanden-notaufnahme-b0a663466be3@brauner>
Autocrypt: addr=slava@dubeyko.com; prefer-encrypt=mutual;
 keydata=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
 NFdvziOa4FgUBC4X71upsZIoZJeii2V/Jtc3B4g==
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2-9 
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

On Fri, 2026-11-20 at 14:48 +0100, Christian Brauner wrote:
> On Tue, Nov 17, 2026 at 04:48:40PM -0800, Viacheslav Dubeyko wrote:
> > The helper updates i_size without any locking, so it can be used
> > only
> > by file systems that issue all direct writes extending i_size
> > synchronously (IOMAP_DIO_FORCE_WAIT) under inode_lock.
>=20
> Meh, this should really not be named so it looks like its the default
> completion handler. iomap_dio_end_io() really sounds like it.
>=20
> Name it after what it does. Plus, check the rule. With
> IOMAP_DIO_FORCE_WAIT the completion runs in the context that still
> holds
> the inode lock, so the branch that updates i_size can assert that:
>=20
> 	if (size && i_size_read(inode) < iocb->ki_pos + size) {
> 		lockdep_assert_held_write(&inode->i_rwsem);
> 		i_size_write(inode, iocb->ki_pos + size);
> 		mark_inode_dirty(inode);
> 	}
>=20

Makes sense. Thanks for suggestion.

> > +static inline
> > +int iomap_dio_end_io(struct kiocb *iocb, ssize_t size,
>=20
> This is an ->end_io callback so its address ends up in struct
> iomap_dio_ops. Please make it a regular exported function in
> fs/iomap/direct-io.c instead of a static inline in the header.
>=20

Sounds good.

> > Several file systems implement an almost identical ->end_io
> > callback
> > for direct writes: if the write succeeded and went beyond the
> > current
> > end-of-file, update i_size and mark the inode dirty (for example,
> > ext2_dio_write_end_io()). Add a generic iomap_dio_end_io() helper
> > for
> > this case, so that file systems don't need to open-code it.
>=20
> Hopefully that gets a follow-up patch right away and converts ext2.

I'll do my best. :)

Thanks,
Slava.
