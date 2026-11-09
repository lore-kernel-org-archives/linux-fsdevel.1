Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=91.218.175.115
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794228832;
	b=pyGfb1wurm58P9Yo6Z0RH7C0Q0/5LjgIvToTO03jVF9WOKHgQTWlcOUGabKRK4Ob5G5L
	 EBz1+YlZNrRnVgMkN1OjQwPfhLg3ffdjl9deaULCHAeqf1BeeovV8vDJnupTZI9MEgRaS
	 rP/zzhdwznXviK23/mW5K4aXNeYnOKTHmVB/diIzljfZbussQjd3B1D+ovEPlM4VsQO/2
	 rHhFN9iY+Uzff5CfXsvkK5hKu2hwItUupB9nVPsAp2yFwPuV7D3me3z7J1hDtzRyCnBNL
	 Bcw6N33C7SiTAUPchURfcDxfGmpbjkaI3051F3TEQDYOdLUHELhOqlKSUmKUJS4Ogdg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794228832;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:Received:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type;
	bh=xsolfVVWbRORmL7YZZKbpcvUqqBN4m/xr4JBostwKXI=;
	b=xBxKo1uIcgClPgao/BRw7EigY2KsmFJSllD8Q9Yj0Y50BzvRYqtCZf3/Nc+rOiEg+cIk
	 8pVyagmxq10ABKKx3LD1R8bPWslDYqC/iUEuoM1EETE7I3bAQUxjlsG/dMtjFgN0e3bkR
	 cpvqodL7yH7UhQ+qmdsxXTdLOdGEVyfiekcP9EQzqVPAlbs9dx+G4FO9LlDmdrK57ynJq
	 oR/wAA90PTKVRJVWBenr8gvJ7UAFg57WVAoz1JUO45/KxlCH54ALhnwBzvSZrHTceAAAt
	 sqkjHqNjVMmer712cDMMj2a98vaGY2HgEc7XkjdSyJvytd/XBeBDO1o/44ps0xJgyRQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=D5YTQ8ou;
	arc=none smtp.remote-ip=91.218.175.115
Received: from mta0.migadu.com (out-115.mta0.migadu.com [91.218.175.115])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43AF2606A333
	for <linux-fsdevel@vger.kernel.org>; Mon,  9 Nov 2026 12:53:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 43AF2606A333
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=D5YTQ8ou
X-Envelope-To: linux-fsdevel@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=xsolfVVWbRORmL7YZZKbpcvUqqBN4m/xr4JBostwKXI=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1794228829; v=1; x=1794833629;
 b=D5YTQ8ouE+25VC2GZ+u7sTiV8IUMj4amnhuD1OmqB+I8tXSvwJC3P9a0l71VVFQFK+4MmeE/
 yzPHuUiGGiqQwKL3+89x9UYkyfdb2YKGVUa/tJTzv+p9Q5V7B5sio9lE/sJM8yCPP6iLhYOTsxP
 6HnLJsxQtiFROWMHv4trQ58U=
X-Envelope-To: linux-fsdevel@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 3e5a50d809f86ab9;
	Mon, 09 Nov 2026 12:53:49 +0000
X-Mizu-Trace-ID: 3e5a50d809f86ab9
X-Migadu-Flow: FLOW_OUT
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-5c14bc5a743so4935e87.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 09 Nov 2026 04:53:44 -0800 (PST)
X-Forwarded-Encrypted: i=1; AL+hErEjOg8Fi9e1OZZZw/0zRnkPhFdwHnT91r1ai+pPMETFou5cULUWvOJClyTRnBRHyVGg93P8ol7W6YxUsrS1@vger.kernel.org
X-Gm-Message-State: APuU4Z/GhejfheVvLG9wwQ4W5+uE50GHfNzpQZIkVk+7t4JSnV3+9J4u
	doz33+0cFnlD/qyrhjirquooDhZGXv8ThDSWMt0vxj62zKslV+Z9qcgoWT5TgHBMITt8vOU+SdT
	aVzG30qTy7VcJHxW2zU28wm7NdUy/iRhVhFlDuT/5
X-Received: by 2002:a05:6512:1296:b0:5bf:f060:c0f3 with SMTP id
 2adb3069b0e04-5c00bd5d693mr185283e87.12.1794228823188; Mon, 09 Nov 2026
 04:53:43 -0800 (PST)
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261108200141.383158-1-fuad.tabba@linux.dev> <20261108200141.383158-2-fuad.tabba@linux.dev>
 <87ld72f9rf.fsf@mail.parknet.co.jp>
In-Reply-To: <87ld72f9rf.fsf@mail.parknet.co.jp>
From: Fuad Tabba <fuad.tabba@linux.dev>
Date: Mon, 9 Nov 2026 12:53:06 +0000
X-Gmail-Original-Message-ID: <CA+EHjTyouGHwy4nYAfGuNeMp6NXhhatNp2ambAzdQMxv0AXp_A@mail.gmail.com>
X-Gm-Features: AclHuK_ZmCOyHXfQ_oS5KSMvwNHpXLhELyCWXJ7DxRnrCffbYDVqCAYceYWYm1o
Message-ID: <CA+EHjTyouGHwy4nYAfGuNeMp6NXhhatNp2ambAzdQMxv0AXp_A@mail.gmail.com>
Subject: Re: [PATCH 1/2] fs/nls: Add codepage 720 (Arabic)
To: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Cc: brauner@kernel.org, viro@zeniv.linux.org.uk, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 9 Nov 2026 at 12:51, OGAWA Hirofumi <hirofumi@mail.parknet.co.jp> wrote:
>
> Fuad Tabba <fuad.tabba@linux.dev> writes:
>
> > FAT stores short names in the OEM code page of the system that wrote
> > them, and the OEM code page of Arabic Windows is 720. The kernel's only
> > DOS code page for Arabic is cp864, so mounting such a volume with
> > codepage=720 fails with "codepage cp720 not found".
> >
> > Add nls_cp720 behind NLS_CODEPAGE_720, with tables generated by a
> > script from Microsoft's code page 720 table, as ICU's windows-720-2000
> > mapping carries it. That table maps 0x80, 0x81, 0x84, 0x86 and
> > 0x8d-0x90 to C1 controls, and those eight bytes are left unassigned, as
> > ICU's ibm-720 mapping leaves them.
> >
> > Signed-off-by: Fuad Tabba <fuad.tabba@linux.dev>
>
> Looks good. However, maybe no maintainer in this area, so I'm not sure
> who handle...

I was wondering the same thing :)

Thanks,
/fuad
