Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.54
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792854748;
	b=nXnB2bP82dkrRp7jNu6TTTM5C0fZ/4PzQHtxPhm4OUmPRaLvV41rWaYnRPDJXAmiwHK5
	 bo2PP7jfiA6970xbrrG4ySsSdWtbth4EyuRUucpjmXP+bBNSV9c8dI8saoWN4SNgO0R2i
	 a2ZMqBkJve3s2wKhjUUbEROlhREPCbW7IRCo75tJ8RsV7eSLKm7rFh5AYzguXcRj6jA3L
	 dN/lXDzWKQJkfindtY87BuahSrPIowbEYMz7ALZuFN8Sr2jRfrM6X/h1c0O4foMwBzdjS
	 EBX16c0f5RixjL8ab21NptHOJUR5NqAbezLYLCs7qZ8fBfwDhQniN4AExJmGoD7rdcQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792854748;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=MyY2jy4KUwx/K3rgfa29m+xcrAnt+SzmlWOsNDROzng=;
	b=UeVo3yFFJpbadVjIabnSm5nhQs6mkNEC9ZhdOUZc9ybJgt+VHsDPHClvFyby9dwddrAy
	 dY9ZR93T4KeJyHHrhJT1cOfzL0xPaLA+GhNslpD2D7bDiaZRJSGcfQzWWxohWUsI9g/UE
	 s25aCWI0+Ez1bvKT0899FExs45dsiSJBT0Bk7x7IYFukRmQ+dSKOcykVpd9iq7WGFyI0y
	 RxzXQhaEMknupwiLSr+3P70JPEYife6ZOunpniQ6KtHtKsn8NelpGF9a+XkOBy7ftyaW8
	 aJWgWbljWyJloJn67jFbfnmYoi/eix2dDRmj+R74xjBN0XmqHPuDeyviHhE1cVFNv0Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=hackers.camp;
	spf=pass smtp.mailfrom=gmail.com;
	arc=none smtp.remote-ip=209.85.221.54
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BCEA606A31A
	for <linux-fsdevel@vger.kernel.org>; Sat, 24 Oct 2026 15:12:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1BCEA606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hackers.camp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-48bbb06f29bso249292f8f.3
        for <linux-fsdevel@vger.kernel.org>; Sat, 24 Oct 2026 08:12:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792854746; x=1793459546;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=MyY2jy4KUwx/K3rgfa29m+xcrAnt+SzmlWOsNDROzng=;
        b=QgjJpLYOjG+KDeq4irUN6lfu8YnFHz8LnzNGQH5/yxG1HOHUwlDY/TkXFBVdLdS077
         QHd3jrchQ8/qcHxtcZIlc/lYuFQJ2It3KnrR0vpHt7a9jSpgLofy7Er0Qb0JZ5zyqbzp
         iHeGrEHDCyJ4bhvGYgMuKSahlybw9lDjbm2RpG8kXebWWFNJ3CWQgD8FRuqZqqv/zQcP
         V1iKseKOsZS2JJokB3mRrx2VNDdSBmqpecFoxWXxlsfH65Ieo8UDc2FNsB5rAl9e8FeL
         sxXWJK7nf+oT0Us4OyPL+VMYM8pKDctnNOfIKhSw6DbgVurv4MvJXYTbX8861qs1shMS
         omQQ==
X-Forwarded-Encrypted: i=1; AKwUvBzYf/6bD6xXcH6vmOxBMrrnhsg+i0AGpV/SUklK/9sj/k7m9+ff6+HpQ/vtq7fNVOY+2TZxBI5WPtFw1dZK@vger.kernel.org
X-Gm-Message-State: AFq9FYLJnl0+ncJ3FsrTAXyrprZnWOpraUhTS4//h0Oa4UzYfNxTZBgf
	CrQMVSPZ0fxYmHjIy/O/zwMqYULeJe3N6f5wjeYQPMlrKUhxL+sFkcR9
X-Gm-Gg: AYBFou0LZTVobSElYCsJUm7Tp+WWVmcywzWemwiT6yZuQ2VOxfNgoLeihnM9QFoMk3Z
	jlbVT0MWwTlQSYX0yMbtGyuxGQE3UCxJtGfatLfvLPltdxVrebUSZB0/On5nNuxrrDNI4oChg9P
	uxzaDJgM8WJ0RW7nL14pYDn/fMrrZz5CIQaeOMna8pIlowyyUkQQwpr3RH3xezf7Zm1WQmVKXqP
	pM0QHTiySguWvZNfXPhvyhzM14tGSefAvNQZswPinlpvQ8BHXlDvV76Vp620VJzTAyTvWoktTqb
	pEUIXfVoruKFogH9AU4bTiEhWwbGYkFSQKZH3xKsvjlMmZnPANywvnv9E0Mq8stw7t+OjGjpT3T
	s5hEfsN/kovBQfJ2AIOkK1Rt+iA+WhSyTvYyRTOl4spY4DV9Chh7uktm8ZhQgRqgQAWpf8If4Tb
	YclZP9PPIijgxd4hkSKQ1EwZxeyWCRrS/FFtsva5DLhc3l5zy0PPpNlwoSD2PYV58PHPY8XA/mn
	QQVBgN8l9EXIyUGKEend3miq9yp6OufYLHI7REY3HdePDI3q+ObKv5hchvoZFiGUZkLFIxwk2xu
	DsHWnFNdkPMI6y1+EyAP1FsaCdQ/TAWOH3Sydmo=
X-Received: by 2002:a5d:4245:0:b0:48d:f4e6:7b2 with SMTP id ffacd0b85a97d-48e3eb8705bmr2186375f8f.3.1792854746356;
        Sat, 24 Oct 2026 08:12:26 -0700 (PDT)
Received: from spartian.home ([2a01:cb1c:76:ed00:602f:c5f4:d108:b925])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e3ecd8ddasm5353538f8f.48.2026.10.24.08.12.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 Oct 2026 08:12:25 -0700 (PDT)
From: Aurelien DESBRIERES <aurelien@hackers.camp>
To: rdunlap@infradead.org
Cc: corbet@lwn.net,
	skhan@linuxfoundation.org,
	viro@zeniv.linux.org.uk,
	brauner@kernel.org,
	jack@suse.cz,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-api@vger.kernel.org,
	aurelien.desbrieres@gmail.com
Subject: Re: [RFC PATCH 18/18] MAINTAINERS: add beamfs
Date: Sat, 24 Oct 2026 17:12:24 +0200
Message-ID: <20261024151224.47953-1-aurelien@hackers.camp>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <4ebbbb17-7833-4a2c-9e7e-b3c731873caf@infradead.org>
References: <4ebbbb17-7833-4a2c-9e7e-b3c731873caf@infradead.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On 10/19/26 11:38 PM, Randy Dunlap wrote:
> Entries in the MAINTAINERS file should be in alphabetical order,
> so between these 2 entries, please:
>
> BDISP ST MEDIA DRIVER
>
> BECKHOFF CX5020 ETHERCAT MASTER DRIVER

Will do, thanks. The tool that places the block stopped at the first
title sorting after BEAMFS, and in this tree that is LPC32XX DMAMUX
SUPPORT, which sits among the ARM/ entries; it now wants two ordered
neighbours. v2 will have the entry between BDISP and BECKHOFF.

Aurelien
