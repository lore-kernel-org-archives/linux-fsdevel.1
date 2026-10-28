Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=170.10.133.124
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793225386;
	b=ABb4bWbIWCSdiY/bBR7+GkRLTaf/pw5FNw+PZlYkCjURNNjYityi45swP5cmBNBowSaR
	 SlLTipRHFF59w0TTGJGt8+V6r4MP7abZa52IZKWJ59Ucrn8AJq6DGWUnm63EeOPIgV5r+
	 Nd9oQUZo4SXwxW/3L3sto93qKSss1N9Nky6wVIJZ811fJZDjStcuw2WDn0D9GbOuGUqy5
	 UK1Qh1GuaibGlnI1obzkNlK2Ib6xkQX5RzPnJV1dXyPRhQV0aSOwg6sPHVtTxKt+latre
	 eHE8Ev9zVkiubnmZrkpYzt3P8SMCdgGLNbjn1byahUR4hJZIE4hMb39iPITK23fb0Zg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793225386;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:MIME-Version:References:In-Reply-To:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:
	 Content-Transfer-Encoding;
	bh=j5xHrk121VJ6jsiOiBImMpaem11Ex15L22vqkzMRx+Y=;
	b=nK6w4O0Nz/cxxJECn9eKyvs1umyYZT45ya33FhyoFCUWGOgXAxY/ePLTr1bFH7krqwJn
	 VvEV0PJzT+Xe5uYLxqzauP6jEQGp9dbKb1A3JShF2QqnkjNVCwAyJLFHLYPteYdALIOha
	 /gyrpENk8w5dcAtsNRmaauzh+3+80Ty8ctT32FNbMHThaa6CCE5eKqLMhHxFeGtEwAjL7
	 7jPJILo0r6qJX7pVyBzaWoMHF0CTSxIbfj6cmJTbJH9bDhY3lTVVPFi/ao0I2lLtWVyIX
	 f/PaJzufukG94jgtQB+72jonqm4draOFobyP9k6eZ8uaaBwwgGPgPsRm0XVL+E0wR2g==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=TedXizmB;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=dMvVeWef;
	arc=pass header.oldest-pass=0 smtp.remote-ip=170.10.133.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D37B1606A322
	for <linux-fsdevel@vger.kernel.org>; Wed, 28 Oct 2026 22:09:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D37B1606A322
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=TedXizmB;
	dkim=pass (2048-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=dMvVeWef
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1793225385;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=j5xHrk121VJ6jsiOiBImMpaem11Ex15L22vqkzMRx+Y=;
	b=TedXizmB7pROzC9yt8Z7ACZA27xmpwy51y1aiuneppXqSiGKuR4aEsoOr5xdk5Ne2ImeGL
	TD0uumQBds8lae5xyjeYMpYLNeI0EGFYWRwMn0ARRw517Vnw/+0vjBkglsRXZYrpE3z08j
	IwWw0vrVGXZU3PtiX9cbWcUB9LBKFA4=
Received: from mail-yx1-f70.google.com (mail-yx1-f70.google.com
 [74.125.224.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-454-CvZXkKzmNqel56jEAdyD6g-1; Wed, 28 Oct 2026 18:09:43 -0400
X-MC-Unique: CvZXkKzmNqel56jEAdyD6g-1
X-Mimecast-MFC-AGG-ID: CvZXkKzmNqel56jEAdyD6g_1793225383
Received: by mail-yx1-f70.google.com with SMTP id 956f58d0204a3-6795a39e53fso247623d50.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 28 Oct 2026 15:09:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793225383; cv=none;
        d=google.com; s=arc-20260327;
        b=MLUDAdwRPdbvm30nHSu2k92L4/Dm50YjwZCYy2QiuYV1uAjI19mpMpwaeicRmXP65/
         8/qs9WJVnGS3JoxKs+XLh4U9/yuE+s6+oOEZt0mnkfykvhQkAK24CzTgHR+lMCMJGkFZ
         FMzi7utOUt2w5gBuahUXTN+ZRmPQ/C4eSr3HbiuTT/1P/hnTptYILTKZ8IP7Cdv3LFa/
         xe9F+oTRIoPtaZWdCkgyxSj+8yqgQq5LS7Y5oKpFXaMxWH5EF88XAtBfaTCLT3mCTnBI
         Ogj254fvHfB51NHAyGEwqQLjwNBSl5d8yhz34DSVsSUIDmuIxc4jZ2uATAX8WCp8JWgn
         Jtrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=j5xHrk121VJ6jsiOiBImMpaem11Ex15L22vqkzMRx+Y=;
        fh=sgHMTyFam4pIOHH+tK2PePIQwAPcdHAg+Yf6XGWmBlQ=;
        b=JRSEJOk98Q/LjvOdKF7FqgJKe469p+ZUhRvt5leL81IpnqewaxaJNLPpEnoFGznSf/
         5mwuL2CpTyQ872CSqD8kVhCq2d+bWRclv6VfWz3SE14q4ry2pezJ+p0r5yPguGv8CSTs
         0gU2wC13RC4gTJLKkrG37NW1ftIm37dW9mESU52z3txF5hhy0E4Ccoo7EvtDqpCU3pvx
         8QUBFFBDlPvaOXax1wx8yZFxSW4ptjMoymSeeMrKaH7kcuQYDUqD/2JfCTekntfbJk49
         hUBxghRQ1R1ClG6Vxxcv1VO2QNvqtsiNb+dZ6/uZPdAvT+AY0c/0LEyKMAVsySAd8WHY
         kzWQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1793225383; x=1793830183; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=j5xHrk121VJ6jsiOiBImMpaem11Ex15L22vqkzMRx+Y=;
        b=dMvVeWefC8P+UdQKNVCTRzDnhWHngZQGob2rSgzwsZSnRN8SAHr7CL96OPYJXufFq7
         zSTFFPllhPr/w76wrseeWsykFIT3XNeylizZvRvScikFw2Vx8ZBVf5aKYuJSSTUPuuch
         XBaTxNgE5Gyy25Odb94BXqgaNMMlvyhAsHvl+cohQ1ckCaDBDm4+NkPEdFeD/j45D4SX
         9JdubWa1Rkola0sqbNiDrUuR0ynjj8Js5euvpFf83x/dOZOzpzImQtYe9Q9exxMiq/qr
         mXS/pEC6VjG6Gc4ktJQ1wDheP9WEZsIfL+MfkoZBHHuqMX4NfKOOS6gRPfYVsrX4HqWa
         L7zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793225383; x=1793830183;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=j5xHrk121VJ6jsiOiBImMpaem11Ex15L22vqkzMRx+Y=;
        b=HC0ugrTPjsm0EZ+VG3NiROOIfNuecZeSzdeI2BtiOx1nX6tjdAUqU4efaQPS01t+yy
         2YQqrXrnTV8npYqBDW36UUDj42Pp7LqKJmhuKpCvOzpH3JxYBa/r9wtEKH0prcgxpCGb
         jJqLlE1jFwnWc2ieBYvKvdF19DOXNhdKnrfRPNtfQFY49wb7NMqe2sFFeFRnKkOkNKFx
         cU7boYtnBnyvGRFCpyu8J5h9LQpO7jgWmOHwmg86yi4sWr7V08zwckOGVivzfA61NbS5
         4drED+TTk5tdUE0PPpkQtyWH35rnGaUjEBMSo+mYybglbG7xg3cRoztjgxwFA5uEM3My
         Eqvg==
X-Forwarded-Encrypted: i=1; AKwUvBzEiLRcgw1GOuAm5HF61LTM/C+r3O8E96Xj8h5r/BsGOO5TxALesokYSkUYq26C5N71EjIQIzbOlYvGEvOp@vger.kernel.org
X-Gm-Message-State: AFq9FYKxJ8gQ5AzQc74/bac2JVmdbCGi1CfRbTU9CTQF88kRZpSTWBRy
	ELMQk3laTZ1s/BSlxA8wGJL7KVsa5WPqTpbGSK8BtHxv4wpGfqZTFUy2w1pSGS6e/1WfqNFiw3H
	TOEveCRvYSm0TFR2snysaUwU5iCQtuu+0EUOE69HvCEWFXUNoWeHk+JjfYLcpK4SqJru6Q2md5Y
	3vvwKmZ9nAON9CSeaW/RzfBsclMVeML38YaIMtlYG8PA==
X-Gm-Gg: AYBFou2BkJtsOdLJ1akmpU9k3lJZn78lAjj7wb7RCkUho3vAI2bp1pg43QBdU0cul7C
	lWAecLP9cjC9zxBEokF9ftqY43lA9pvY1VUHMhZ5fGdmP1XhJ2B7VLhSnRCo9BmCeRYvpbS7MPk
	e6z9IyWzIX/ibNoOg55gj6p/+VMAAmadAnoZrv9lLQB6TuQ3A6B+I91z/RfD7PpYinOq43lQ0sQ
	b569BOnH/NQEm7pmsbkBHhyJy4JgBSEstDKHJ2lQJSdzw==
X-Received: by 2002:a05:690e:1918:b0:679:ad2f:3fbf with SMTP id 956f58d0204a3-67a8d0047a5mr704873d50.8.1793225382848;
        Wed, 28 Oct 2026 15:09:42 -0700 (PDT)
X-Received: by 2002:a05:690e:1918:b0:679:ad2f:3fbf with SMTP id
 956f58d0204a3-67a8d0047a5mr704846d50.8.1793225382297; Wed, 28 Oct 2026
 15:09:42 -0700 (PDT)
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261012-work-fs-sb_rdonly-v1-0-60743a3dc326@kernel.org>
 <20261012-work-fs-sb_rdonly-v1-21-60743a3dc326@kernel.org>
 <CAHc6FU6z4kX5R3Og8m0dYOHsjFcw+4Btvfe87AGPxy_EWs0E7A@mail.gmail.com> <20261028-zurschaustellen-okkupieren-inkompatibel-d11525ce88b8@brauner>
In-Reply-To: <20261028-zurschaustellen-okkupieren-inkompatibel-d11525ce88b8@brauner>
From: Andreas Gruenbacher <agruenba@redhat.com>
Date: Wed, 28 Oct 2026 23:09:31 +0100
X-Gm-Features: AclHuK9MzobLdiG2EG9M5KT_ibZzYxdrTghiXff6ZlesOE7YSK8Ag_RtXekxyZI
Message-ID: <CAHc6FU6VSAWQ4RJTO_eLnpqN5qvrShbJeT+ADwiA6ohpq8dO4Q@mail.gmail.com>
Subject: Re: [PATCH RFC 21/28] gfs2: don't set SB_RDONLY on withdraw
To: Christian Brauner <brauner@kernel.org>
Cc: Jan Kara <jack@suse.com>, Al Viro <viro@zeniv.linux.org.uk>, ecryptfs@vger.kernel.org, 
	linux-ext4@vger.kernel.org, jfs-discussion@lists.sourceforge.net, 
	linux-nilfs@vger.kernel.org, exfat@lists.linux.dev, 
	linux-fsdevel@vger.kernel.org, ntfs@lists.linux.dev, 
	ocfs2-devel@lists.linux.dev, linux-btrfs@vger.kernel.org, 
	gfs2@lists.linux.dev, linux-efi@vger.kernel.org, 
	linux-mtd@lists.infradead.org, linux-xfs@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 28, 2026 at 5:02=E2=80=AFPM Christian Brauner <brauner@kernel.o=
rg> wrote:
> On Fri, Oct 16, 2026 at 02:01:00AM +0200, Andreas Gruenbacher wrote:
> > According to commit d564053f0746 ("GFS2: Clean up freeze code"), the
> > idea of the freeze sysfs file was to make it behave like the FIFREEZE
> > / FITHAW ioctls. This isn't what the code is doing at all.
>
> That's a pre-existing and separate from this series. freeze_store() calls
> freeze_super() and thaw_super() directly with FREEZE_HOLDER_USERSPACE and=
 never
> goes through gfs2_freeze_super() and gfs2_thaw_super(). So it never takes=
 the
> freeze glock. I don't think that's for this series to fix.

I mainly wanted to point out that this behavior isn't intentional.

Thanks,
Andreas

