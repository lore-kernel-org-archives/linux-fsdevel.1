Received: from mail-yx1-f49.google.com (mail-yx1-f49.google.com [74.125.224.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD0F0370D57
	for <linux-fsdevel@vger.kernel.org>; Fri,  4 Sep 2026 10:18:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788517108; cv=pass; b=ARXFNp1PYuDt8qveqDIAJ4Nab5zDmov1TRjQdVe/ZepHp5uXOnut1s5mu8yJPzaPWiXkUVyc/nfxUN3gsDioplxl+uZhhFEE6GZHVKeuls5HRibTG24BtF7+TtulYnkf5TcUcCk3b14ycvjSK/wm0lc12DwFCSMegv9rYf3QMBM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788517108; c=relaxed/simple;
	bh=7ecM1UWhebC/3/+iusmGdcjinHnlJFmUl69Lno0FSOQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TtmqLeJPWEMbJpYpb6jc6WzkXVg5P5vvp4f6yRzMsXIeQGAxd+l3G7SpFFJgcMsLcZPjTRJfbMJIKHuG3M+fOP2keaIsneKM3r3CS8nwZWV1bGFOgiO39iNn8HECg0oC5eSIWI0/fVP4GDoMaURAGf/Qgcs7UyPEp16E8CkbaZw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kvuDQPHC; arc=pass smtp.client-ip=74.125.224.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kvuDQPHC"
Received: by mail-yx1-f49.google.com with SMTP id 956f58d0204a3-66f8908a887so901369d50.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 04 Sep 2026 03:18:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788517102; cv=none;
        d=google.com; s=arc-20260327;
        b=nY4fsUSFKgeeNtb3l0fHs6JfTOrD/+PQl21ZqT+y7WibA0KML/kjlTyMscsjTthqo0
         dB2bJSK2Oix4P7TvoJY1KMdtfaB4WQCDDhV8wOldlCrK2XECwrz6IUGGXZnIRh30cjUp
         CU7LoXQ1mT4ZFKetvbky8Hv9Dc3Lao6pfeTst9iPRYHs/C3otAS3HZ1vS6z5MbEIcpJQ
         x+ulpvKZcJIoV6PDkpC3NMGs1wOxeR8pWIODrDhZWzu5+rn+9Y+yooIxz8zXLv47YdBl
         u/B1f16dmhTU0MpzVB2/DV9iDAqoVpCDl2+vl9k1Kd2Vkl+dkwZpc4jguwRsvxxt1AAu
         2ObA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=7ecM1UWhebC/3/+iusmGdcjinHnlJFmUl69Lno0FSOQ=;
        fh=RkLJnRwxZ65rysVOdpfc/Urp9VrmLGzWH7sCjSAaLjY=;
        b=LWLkQOAHNAki7V/bVwrf2KPu6ILUPJz+qB/KIELOIaKMI0lfEYzrsF5NPsMack98wA
         ilNeUQwQWysLfAps2zRw+kGC1wr6f5iFfWJT1wGx6a/xHuARhfU5qUJyddZJD5TY+uJW
         TQIx7gTdgPuAs6ByjPXL9sFDqLIdE9DWrxpypgjJ6zJ+JiHP3LyD4MzAbV67t+oyHtt1
         i9Pq7ch1Jq6qAV0ygCxfeFk1ewz0yH3CO24tke7sGY87KuZ1xRl+iYu9DYYRiL4qCIKZ
         VIKT1rCtrMzLhJjIS+OZeCoS+FqAksTYOxIUrxrDfnWm7V08jierTn58jEgjoub80ht2
         Xb3A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788517102; x=1789121902; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=7ecM1UWhebC/3/+iusmGdcjinHnlJFmUl69Lno0FSOQ=;
        b=kvuDQPHChtGy+Kras+DtQIaJcoSrp84OfcYDEQHyfthx/6KkS8IPv6XcB4s0K2m1oa
         2KU4yDtXhgoHzdbgJpb7Lhkm4wd5nzbANlF1SvRHRzSg5MTOoZ3mEIZEMNvu9erpmofB
         VoUOtzy5Y+8b9w/iKXQvIaDvni9qXiKWNBtG6ybsHC9leQj/M0BN04NaIPVxc024gcu3
         48ujquQAK5YpBGCXBzeg43NkgB+Jg9oEPWbcuuOABM2En42qHFcQbVTPL5KkaykdYDzH
         6WzExmw/8trIvYdXGpeQmxaD+++QdqrAkQPxjGkPdKu2i5nWBrweHQMSoFTv3jRaTJRn
         ZDgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788517102; x=1789121902;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=7ecM1UWhebC/3/+iusmGdcjinHnlJFmUl69Lno0FSOQ=;
        b=ZXoh8fGi/1yI1DVKG6hX2lEFOYclA8MdsAKt0wZfBRaUFf3fpKwSxchqci2G6Y1mdq
         wmbJans99jQZ+NkmlwgGdG5UxM5k1FF2fl6/HV043Nl9nlEV5v599j3gh8IgM/oCYM/M
         UuKnc4AZpf19fNGIrYjSKvJzWfBpaofLuwRvdZVbLRCAgl91Wc7V5FDhJXpEus6gjYZp
         lhr24yBlKeTIu6QDFU+jXD9Jt6remHcMQy7DCXJZrfYv1esPvg5JuY1yq78/VZ2GGCjh
         aF91E3+hpVWgD/lIgScTUmOliQnW7fJwCPpqL2jLRRKrajU6/w3QlHgLMlf02N8ed2r4
         cz/A==
X-Forwarded-Encrypted: i=1; AKwUvBwrUBoeDgZ5GYwhhC6uTaqFbT7NhZFUJcICJj4BSOPFKvLGV2fcGDFTag5badlYhemun2Ma/gkRnYY2n/oA@vger.kernel.org
X-Gm-Message-State: AFuF++kkfi/Ka7uhmJoXFrpxp2i+4LewEfJ8UuZmIwXlcaxOt2E29jZQ
	MNKLQidxAeUGsArwvMW1j7sZo/OQ4ry633bP5c/3+qaiYGZAL3urkzS92MXSR0kjQLRlRiD+Zwo
	WO+cr1U8uzG3BTEA6PNdYs5UGFYdNKcg=
X-Gm-Gg: AYBFou1h6MMqMNCKax55QCR0UG1g/XmUKDXPOWNwSs5mox1JXzxbE+R/3DkOrysi8Yr
	u4YsuHozAFq1dMk2OMXwahlzBqt9jF4G40ezNg/osQmR/lfqWSF7FvAFIWT092F0/5HExRhgU7v
	vnkXnou+GelqAFo20cQfBiMbZPh8XW/U4U6ptWpbhCd35ZLqnjzXN5VPwNAAEvWPE4pCBnq0BdR
	0w0OKOLlBouJH00ELPboLISJrvD0RLfC2cmvqNhdUEx4D/q04bSb0T8NW47FnCvrQAoomgfVAvU
	ry312ZLfVfDY12j8QKFCUXBkJElzkXazzJ01fJ7+wf7QU+bMlUMzRUvPc+opBqX8TwaJOI6MDLi
	h
X-Received: by 2002:a53:c053:0:20b0:66f:a1b4:741c with SMTP id
 956f58d0204a3-66fb5958686mr1624093d50.12.1788517102415; Fri, 04 Sep 2026
 03:18:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260904082954.48738-1-enelsonmoore@gmail.com> <apqXNCL4X_i6xy2Z@gremlin>
In-Reply-To: <apqXNCL4X_i6xy2Z@gremlin>
From: Tigran Aivazian <aivazian.tigran@gmail.com>
Date: Fri, 4 Sep 2026 11:18:10 +0100
X-Gm-Features: AcwNN1X7ex5eCk4ouskYN2ChvEs-v8zBI8q8LI-VGa7gCcqGKoso7q1xSbR0jLY
Message-ID: <CAK+_RLm9HKkm8YCCanpOMxaMaAkt5eoxQBHBxC1-Xkvj=L=UsQ@mail.gmail.com>
Subject: Re: [PATCH] bfs: remove the filesystem
To: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
Cc: Ethan Nelson-Moore <enelsonmoore@gmail.com>, Shuah Khan <skhan@linuxfoundation.org>, 
	Randy Dunlap <rdunlap@infradead.org>, Michael Ellerman <mpe@ellerman.id.au>, 
	Nicholas Piggin <npiggin@gmail.com>, "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, Jan Kara <jack@suse.cz>, 
	Jakub Kicinski <kuba@kernel.org>, Namjae Jeon <linkinjeon@kernel.org>, 
	Hisam Mehboob <hisamshar@gmail.com>, =?UTF-8?Q?Martin_Kepplinger=2DNovakovi=C4=87?= <martink@posteo.de>, 
	Christian Brauner <brauner@kernel.org>, Amir Goldstein <amir73il@gmail.com>, 
	Bagas Sanjaya <bagasdotme@gmail.com>, Eric Biggers <ebiggers@kernel.org>, 
	Geert Uytterhoeven <geert@linux-m68k.org>, David Howells <dhowells@redhat.com>, 
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>, "Theodore Ts'o" <tytso@mit.edu>, 
	Catalin Iacob <iacobcatalin@gmail.com>, Stephen Hemminger <stephen@networkplumber.org>, 
	Andrew Lunn <andrew@lunn.ch>, "Maciej W. Rozycki" <macro@orcam.me.uk>, Andrei Vagin <avagin@gmail.com>, 
	Wei Yang <richard.weiyang@gmail.com>, Bhavik Sachdev <b.sachdev1904@gmail.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Wang Yan <wangyan01@kylinos.cn>, 
	Bala-Vignesh-Reddy <reddybalavignesh9979@gmail.com>, Malaya Kumar Rout <malayarout91@gmail.com>, 
	linux-doc@vger.kernel.org, linux-mips@vger.kernel.org, 
	linuxppc-dev@lists.ozlabs.org, linux-fsdevel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, Luis de Bethencourt <luisbg@kernel.org>, 
	Salah Triki <salah.triki@gmail.com>, Jonathan Corbet <corbet@lwn.net>, 
	Madhavan Srinivasan <maddy@linux.ibm.com>, Alexander Viro <viro@zeniv.linux.org.uk>
Content-Type: text/plain; charset="UTF-8"

On Fri, 4 Sept 2026 at 11:05, Lorenzo Stoakes (ARM) <ljs@kernel.org> wrote:
> Based on Jan's feedback at [0] that closes the loop (it is indeed a
> maintenance headache):
>
> Acked-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
>
> [0]:https://lore.kernel.org/all/35dsgpk5dsh6bm4xoblrq6hdslfvtuibl5grzag37cye2hgepk@rkrtkjxdyk5g/

Ok, I won't cry about it :)

In fact, if I may, I would like to say that it is a pleasure to be in
your (pl.) company once again. Looking at the list of people included
here -- some familiar, some unfamiliar -- I remember the younger days.
I have done my tiny share of contributing to the Linux kernel as best
as I could, but as I now grow older I can no longer maintain BFS
(older does not mean inactive, just active at other things), so if it
does give maintenance headache, by all means -- remove it :)

Acked-by: Tigran Aivazian <aivazian.tigran@gmail.com>

PS. This reminds me of d'Artagnan's phrase from the Soviet version of
"The Three Musketeers" -- "my consolation is that if I am to be
killed, I will be killed by a true musketeer" :)
