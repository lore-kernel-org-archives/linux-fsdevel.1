Received: from mail-dy1-f178.google.com (mail-dy1-f178.google.com [74.125.82.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1687E328635
	for <linux-fsdevel@vger.kernel.org>; Tue,  9 Jun 2026 14:11:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.178
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781014276; cv=pass; b=Fa2Kz6nxVRRTuO7J0qGv24jHa3Bsni/YVIJGvZpGZy1VK2GkBlDWoVygSWAJAin0riR0Urf27o1Gmbt9LkKJjOIlxsyinm96S23/LC+97lFUqgnGZ9TF7W5rhv4v9qmyLKaIxr009B6HR3n6+4WAYFp9m21uwcDJVl/UYAQGU7c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781014276; c=relaxed/simple;
	bh=O7/vXOHmBuDEN6iYoEcXZX9SQVUOxuFM9K3LUsWI6j0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZIcn2G9x/RP+cJTydHerC33qcXMZPz583ccjkspcxoe7wOAtyN3kFg1/Mw2yRM/CKZHMVMz1hlPZIlI67E7Z5hc+yOsAgNGPNedA+gXc4rDtvk0ZXhpbGgkLLgHAliRiHzB0eZZEbyUYuTiG2gcX1gZTVixq5qUf4YtOFahV4Ws=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pO6mb/Mj; arc=pass smtp.client-ip=74.125.82.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pO6mb/Mj"
Received: by mail-dy1-f178.google.com with SMTP id 5a478bee46e88-304f9bc869aso679094eec.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 09 Jun 2026 07:11:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781014274; cv=none;
        d=google.com; s=arc-20240605;
        b=RkCzJfag/ag6700LNpSjxkeMQ9eZmf2YTFTRiaQG00vmxrMu/AHCOvPBDpR1eewCwG
         V46yWMoEH+KK1t/lwnWowtQT+OYHDtkEdEW9bd2WWtxhVJ8yIdIKJ2LuORKmRI1VTR7b
         xmnPDtJAIjhrXcBPCamtQE56pN/xgXHfEuxKOgp5+9OgeGuos3QmF2pbv9+T0NuDedg2
         KBx3qdH6szW+DtnmiIxIfyI3JVaZyOURolN5l2LXVPhLCUC6FYprxR9GVbWRcgERWxfJ
         cNQi0s4VMyzszdnDXsHDb+US/PcVNHOpFzopkEdWOzlS/K1BJkIFaQdHWSYhJGze5kwb
         45kA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=nhjDW0OszKJAGtPcPLD3bV8YMBm1E7bkkVTPi52pFmI=;
        fh=7tdmbwacFtZNau6o+AHC/2Kd08FsuU2McOQe7HQwBR8=;
        b=JYyyJMdcQZXjWgOjNhoso7LW80WX3p36XdNxMJTp95mepkAT5H3VrCQGq4tTJ//QTR
         ifnqBRsFDxsYt0geHEFtwDccSTitN7bBJfiqiL6qX9L8wrMWsqdgKeco0g4rQb106SZv
         9QmCXV97Q+P3SP9fs6tpkoWXH3lLGQmqnFJrGbCZ/GP2FQ6WZsCQI+SilCDo8gapgTl4
         o63CTn8/zBl85GDcndtUuGolsNWhFZ9vxYYeoz3U4CgVoyxVu5+pBhAkC3puUZgWc+8y
         HZNHdRelbWK8tD/7CHAK/a/LJ/F4Ldz4aQDh7eAKQZp5eNWjdYIozCPSOP1PbmIX45pP
         jdXA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781014274; x=1781619074; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nhjDW0OszKJAGtPcPLD3bV8YMBm1E7bkkVTPi52pFmI=;
        b=pO6mb/MjV7+9Lyoy7qKEe8jyrmAVmp1sVk9ZAQekGJY/qcYqRSPwEAedKazW1YDjAo
         daWkJzVnMyQBtO7fmggjHQ1cPEQGXHlt3VIr6I1Kj1CO/2HtnymY1aGpvzlRB8OH+ilA
         890WtpQyksZUJj37x9K37O3XCrrKWsg/O8Y8q+MGEolHuY3O9nF+Mz46OcSl6XEeAyYn
         PpKFuaWCdq+j/LCZ8xHOrMCCjyi8dyUYIO1ZCC3Qs9hwAGz+a0asgrLpY7oQ6QrXmnr+
         SzEi2Ndcvrsr6lg0pp6Uccf0k7gE8QI2hRsXCNfmZx5mer8km0ZAI5cl8BunKE5GWZwg
         VvlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781014274; x=1781619074;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=nhjDW0OszKJAGtPcPLD3bV8YMBm1E7bkkVTPi52pFmI=;
        b=hudXMkyIU11x+yyAK6+/V5bcR/rqkLYu85PdzggMZt1OYrVM9WjTXLHDJcR1UiJa7d
         fndLqUFy+GIHfx0XRZs5ntER+t2QBMz17CqzRFO+K5k/zXdBmqTXZJFkoA+sTaLOx+sq
         Y502/H/7/ID7ClmLsIbui5xHz3enlA/6Abn99cBEePc120sZA2MUEUFC20UjYfhR2iei
         XO7gp81wkEbk7TtrVOPWti+XAk1N7VjRWyYzxR2v6dH/9Yltlm1SZCSQ15M+Qb8h2YvX
         ESgnj2vpDGufcJOVlXm0A09w51uKsgmiZpMgXmR11a7lSlTks86YLY5xUK9FW+R34EE/
         /8mQ==
X-Forwarded-Encrypted: i=1; AFNElJ8yixRiA9QfyFhhyhtzeydqnt94MnlYamGfzDocPXBQ+ft73YqflRUfT8g3rd7PI1c0v7aPeCViGNQEiiEX@vger.kernel.org
X-Gm-Message-State: AOJu0Yys8P8drx5+5UpE5xm8I0ETui3OYes9RBvltbQ00oN3KlXG1CJU
	61rUSrqX1jSyW39LJA7+9C241Vq/v5+kdEWQdHMbttVc71Ub+bTFB6Ec/8kwac6p9WCdz9UZxHy
	olljvA6IHAG4Sk0bIj38ytlAaaGhLgdw=
X-Gm-Gg: Acq92OGq0uSZQshg3rM0Lj6NyM5jarbaX+eoyhPD6hZNUF9UcKsLRGvszTPmUJbLoaE
	KzVAtGzB1LKvGaMZ0r5e0Iom9D14WIl9VaYqaF0Y/WLOiQfoYIbQRY2TA6SoW3Wh67faNlsW0fb
	SMmsTI88INRZzHdzMvgfWepRTnYa60/nSl/Rk5GgIgyVrmPbByuxfP4WjJaXu/tT44IktfHAtc3
	C0YSrP31+J0P/8erkGTOdh4HA+88YiNyHTNsQ4CWkFGoTam7r3NYbj61NyNwJBV4Al4sNGVNrL6
	QUM//VqTH8F6MjMEBIffV3kMMzEyYbjMWla/q7nbUE8RY7uv+Bwe1sLqFiVgDEvp3mwcR1iiWs8
	Y8Q+3VjYqtMoldorrCuUHX6qfZboV2PB3NQ==
X-Received: by 2002:a05:693c:3749:b0:304:8860:74d6 with SMTP id
 5a478bee46e88-3077b21ea10mr6213247eec.1.1781014274135; Tue, 09 Jun 2026
 07:11:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260604-unique-ref-v17-0-7b4c3d2930b9@kernel.org>
In-Reply-To: <20260604-unique-ref-v17-0-7b4c3d2930b9@kernel.org>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Tue, 9 Jun 2026 16:11:01 +0200
X-Gm-Features: AVVi8CfNPwpEZxw0N5nqXBfBlOCze0ATuinL6YIsUVP51KJlhLB9xVsEvEDqHhw
Message-ID: <CANiq72nkYJnztntLzB5jNwi_oRY+V7UMpf6AuKM07aGH9FwPdg@mail.gmail.com>
Subject: Re: [PATCH v17 00/10] rust: add `Ownable` trait and `Owned` type
To: Andreas Hindborg <a.hindborg@kernel.org>
Cc: Miguel Ojeda <ojeda@kernel.org>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <lossin@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
	Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Dave Ertman <david.m.ertman@intel.com>, 
	Ira Weiny <ira.weiny@intel.com>, Leon Romanovsky <leon@kernel.org>, Paul Moore <paul@paul-moore.com>, 
	Serge Hallyn <sergeh@kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>, David Airlie <airlied@gmail.com>, 
	Simona Vetter <simona@ffwll.ch>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	Daniel Almeida <daniel.almeida@collabora.com>, Viresh Kumar <vireshk@kernel.org>, 
	Nishanth Menon <nm@ti.com>, Stephen Boyd <sboyd@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
	=?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
	Boqun Feng <boqun@kernel.org>, Uladzislau Rezki <urezki@gmail.com>, Lorenzo Stoakes <ljs@kernel.org>, 
	Vlastimil Babka <vbabka@kernel.org>, "Liam R. Howlett" <liam@infradead.org>, 
	Igor Korotin <igor.korotin@linux.dev>, Pavel Tikhomirov <ptikhomirov@virtuozzo.com>, 
	linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org, 
	linux-block@vger.kernel.org, linux-security-module@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, linux-fsdevel@vger.kernel.org, 
	linux-mm@kvack.org, linux-pm@vger.kernel.org, linux-pci@vger.kernel.org, 
	driver-core@lists.linux.dev, Asahi Lina <lina+kernel@asahilina.net>, 
	Oliver Mangold <oliver.mangold@pm.me>, Viresh Kumar <viresh.kumar@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 4, 2026 at 10:13=E2=80=AFPM Andreas Hindborg <a.hindborg@kernel=
.org> wrote:
>
>       rust: page: update formatting of `use` statements
>       rust: aref: update formatting of use statements

Applied these to `rust-next` to get them out of the way already since
I have another similar one for `str` I am applying too -- thanks!

    [ Picked from larger series and reworded. - Miguel ]

Cheers,
Miguel
