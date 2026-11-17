Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.48
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794920417;
	b=1YMu5ruGAI1VEck5yQPa19b5Rma8m2RhZOQBj8RYRm48clXzqPrDlFjkGDMEqLPL4KD3
	 MD6lMNKX6YfmrEgD/iKqUOjGJjV5nYR6zI/Cg8bsuxHSdkGbTe8PkCdnIBwlWL2qv0roo
	 aa4FlYofiOP7h+5T3dr7IqheXlDW5qUltT8fLUrXqDsVNTWtm5l5FmxDXap9ZoRshaITt
	 atsK3DcGXsSWDJyrhcy8BlEtq5j+4M2JM3HEl45PmdWbLMnG4mxDchh/moaghc4ZdL4jJ
	 jPnheNRC1jAcLUpXpzhnvDgL5A5ZLKYEDFc3HY58D7NxcTG8gWmA17vqXLsg60CpOvw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794920417;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=ckAIzUV5oWihOIEXseRYjbrEU/6METgnwVW7WGDvtlo=;
	b=ozOXNVfY1OKdmKSqOn5biv4WgoVQtCoAd7P0BD3l00Q7vDOGga+dd4wMxEZx7rtpys4q
	 Z9LF/6j1DZumrJlnoCh35+sSK3Xk4O9GgkLEblKtvDXkqudq5VW6q8KO/fg2VjVybRSuJ
	 GViiXB9YaSxHTlDdFSbRc2D0t55Ep+zc1E+R+BeRlnHkZ+WZ9AAOa3g//sK2NZv7ZCL94
	 H9R3jMV9WEdyADZN8/JXyS+YK1OBqj7tPyNOqyzGB72VpD6eUJUejzCJKClOnyE4D6DbK
	 6S9Ue8iJ/PWXdK4Je4n9sVdNwmnLM/J62C0IA/ycA+dwsF2/wkp8bFlIhcieNb7GSsg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ux9dP6cx;
	arc=none smtp.remote-ip=209.85.221.48
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E76E606A333
	for <linux-fsdevel@vger.kernel.org>; Tue, 17 Nov 2026 13:00:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9E76E606A333
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ux9dP6cx
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-4a358881793so543526f8f.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 17 Nov 2026 05:00:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794920415; x=1795525215; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ckAIzUV5oWihOIEXseRYjbrEU/6METgnwVW7WGDvtlo=;
        b=ux9dP6cxGHchfy+unLDQ6NmKaVT3R8pW2Zfa/bLFviUfqW7T1JZLWOGkLeMvqz7iUB
         zLW7dje3QrA7HvFJ9Z2e/BsWN7PkFukCWLlCC2sfZfe4C42kw1BD7+xJ9+K8ykHcfJhN
         xuB6p0p675+Q+8Ab4VBm/lPttSQUOT9MfXiQdtBTxIq64JfVXTUc/LJnriMOJrmqWlqr
         pVJv7iS/suULfBRGTO/rXud1wwmWfwrXIjLdPTrqTKyk72/ZF/FYEeTqn8YrQOIG851+
         XstWyYcmlUsM5ZYhKgaD6JN4csYJsgqj8fKhGxAJTKSZDhJpxLk/Ya/RZa7YSEnQfkFN
         FNJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794920415; x=1795525215;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ckAIzUV5oWihOIEXseRYjbrEU/6METgnwVW7WGDvtlo=;
        b=H5h5Z4twUFT1TFOGblNm+By+enI2PK/1PIUCoL/YEe3zFXaPGoaePLltMBdG8D7xZN
         kT+4/hlqB+17SNnkj0Hj0qEbfgut2WoiamJxsy7aoHFBnrHWpZkwqsgadDK6Mj5Cgdjw
         77P5FYY18DhQS9nlP3F2TprAj04s7Cfy8T2xMNT/c7QwBv4uHBjzpBSIjeO593/vke/7
         NzNVNHkoDLCXtsjdSARqgyRW4naCUuzmT93+zEmJxQ2UDdnQ+j5AUUAm2oiMetD24bGn
         8yP7ccC2p4gFA1LAgCaI2gxQQNs3Pl2dEbeBAqdIfDv9sb9iucQqQ2yigP8KbE/Ueq7A
         mnmQ==
X-Forwarded-Encrypted: i=1; AL+hErEU3eo3NQ1OUz10unO89egM4/a3xA56n98fGja1O+0Q5phqjpFhcJyufmLxAa2ZMYn/zMk2qf7PNrChQFYl@vger.kernel.org
X-Gm-Message-State: APuU4Z+BSMAqe+A0HqWVIsXyXWLot7OEfLPT8DXG301dGuUuh8eO/wro
	W19UxxjCDgYpav18iiZqN+8DV2d9fCWDvcQ2F5S1RqUyupCsLm6Ybf57
X-Gm-Gg: AZFdTZemgoueI/GUgU9Ie7DZbOoGCc/I0jB0s1SPYk0PFTQzAiaE3y9aa0EJQp/VYUi
	cz2YaR9fSa8HKXJVlB90Qc0w6EWQn5T4V1erwm+DX9ZzTjsny1XHg+78Ali/+iqdzu1xWs1rNGl
	XBsJHrnVyuVYF7gq9P9iT2biQM+XDK74qrEwybzr1l6lWjfqT5IAatvVHqqY9vxaeFB0qhgJs8R
	G8bqk2kuJCa2qCXLNJ0C+xBrj/lhVHNnW+Mo3hMWswS1Ez0+8DewlzHqiZu54tkjyxJaDCDhNGC
	Sg/Y7FekLHqZLgbwU04tqldh3E8WlhlhOZhn6+FbmZtM/CK72s+3WNo2LXwzRLz5HffqDhLu5JR
	cAZUxl7hfLpLcRr5N+D2aecVrBm5sURj6kOwpl4fpnBilnzORrxGTiFv+qlCrzfTgQfUSN80SXS
	qupxNsm0ia1oM676TbSx5is8gJW6w/WHb355deI8VJBeIn7kzrmHCl9dy9UfDey75SNDwSxqcOq
	Au5ulmOrm6oQtDeE9yxCj88m0DuSOr8T7WIfpm/4T8U9nQw+9l+ArWk2e4GD33/3+XGBhqxtWCt
	DMolxOdhqYdK9jsGVWKQmC/qkYy5lLYnxlY+URibyiCe9PJqt/VsyqYxf5QCMAzpMDSmyHrvC11
	+b2S9yCucnIg=
X-Received: by 2002:a05:6000:46d0:b0:498:2754:6a80 with SMTP id ffacd0b85a97d-49c725e538bmr20536616f8f.28.1794920414596;
        Tue, 17 Nov 2026 05:00:14 -0800 (PST)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-49c5ff2be55sm28207005f8f.28.2026.11.17.05.00.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Nov 2026 05:00:13 -0800 (PST)
Date: Tue, 17 Nov 2026 13:00:11 +0000
From: David Laight <david.laight.linux@gmail.com>
To: Samuel Wu <wusamuel@google.com>
Cc: Jonathan Corbet <corbet@lwn.net>, Shuah Khan
 <skhan@linuxfoundation.org>, Randy Dunlap <rdunlap@infradead.org>, Luis
 Chamberlain <mcgrof@kernel.org>, Petr Pavlu <petr.pavlu@suse.com>, Daniel
 Gomez <da.gomez@kernel.org>, Sami Tolvanen <samitolvanen@google.com>, Aaron
 Tomlin <atomlin@atomlin.com>, Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, Alexei
 Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>,
 Kumar Kartikeya Dwivedi <memxor@gmail.com>, Martin KaFai Lau
 <martin.lau@linux.dev>, Song Liu <song@kernel.org>, Yonghong Song
 <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, Emil Tsalapatis
 <emil@etsalapatis.com>, Ihor Solodrai <ihor.solodrai@linux.dev>, Nathan
 Chancellor <nathan@kernel.org>, Nick Desaulniers <ndesaulniers@google.com>,
 Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>,
 Andrew Morton <akpm@linux-foundation.org>, Petr Mladek <pmladek@suse.com>,
 kernel-team@android.com, linux-kernel@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-modules@vger.kernel.org, bpf@vger.kernel.org,
 linux-kselftest@vger.kernel.org, llvm@lists.linux.dev
Subject: Re: [PATCH bpf-next v3 0/9] kallsyms: Add KALLSYMS_QUERY_BY_NAME
 and KALLSYMS_QUERY_BY_ADDR ioctls
Message-ID: <20261117130011.05eee0a9@pumpkin>
In-Reply-To: <CAG2KctpP7QH=tdSB=op703rA=CtjQKAXqOen8JEHg1ygy9sgyg@mail.gmail.com>
References: <20261113221248.3535369-11-wusamuel@google.com>
	<20261115142431.1587690a@pumpkin>
	<CAG2KctpP7QH=tdSB=op703rA=CtjQKAXqOen8JEHg1ygy9sgyg@mail.gmail.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
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
Content-Transfer-Encoding: quoted-printable

On Mon, 16 Nov 2026 19:15:11 -0800
Samuel Wu <wusamuel@google.com> wrote:

> On Sun, Nov 15, 2026 at 6:24=E2=80=AFAM David Laight
> <david.laight.linux@gmail.com> wrote:
> >
> > On Fri, 13 Nov 2026 14:12:45 -0800
> > Samuel Wu <wusamuel@google.com> wrote:
> > =20
> > > /proc/kallsyms is the primary interface for userspace to query the ke=
rnel
> > > symbol table. However, resolving even a handful of symbols or address=
es
> > > requires reading and parsing the entire text file, which is often sev=
eral
> > > megabytes and takes thousands of read() syscalls. =20
> >
> > Separate from this, I've wondered about separating out the /proc/kallsy=
ms
> > code from the code that actually handles the symbol table itself.
> > The two parts are pretty much separate.
> > IIRC it uses a static function to get the symbol type (which does most
> > of the work of getting the name - which it also wants) so it isn't
> > completely trivial.
> >
> > I'm pretty sure all (well almost all) the changes will be lower down
> > the file than my changes and won't cause (hard) conflicts.
> >
> > I've been compiling kernel/kallsyms.c and kernel_kallsyms_selftests.c
> > in userspace for testing both, but had to cut the bottom off kallsyms.c
> > to get it to compile with a sane number of definitions.
> >
> > David =20
>=20
> You mean separating the core symbol code (top of file) from the procfs
> interface (bottom of file) into two separate files, right? If so,
> seems reasonable to me, especially since the file is approaching 1000
> lines even before our changes.
>=20
> And agree, even with both our patches, most functions can remain
> static in their new homes.

I just tried it (on 7.4-rc1).
Only had to make kallsymbols_get_symbol_type(), kallsymbols_expand_symbol()
and get_symbol_offset() non-static (added to kallsyms_internal.h) and
split the file before the definition of kallysms_iter.
Then tidied up a few #includes.

I've found a much bigger problem though.
All the sprint_symbol() functions do unchecked writes into the caller
supplied buffer (no length is passed).
While the buffer is (usually) long enough for the name, there isn't
guaranteed to be enough space for the "+0xoffset [modulename buildid]"
that might easily be another 60 characters.

Some of the people who have modified that code recently really ought
to have fixed it.

David

