Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.208.41
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793723558;
	b=Ei6IQwcdMY8ndgqRqrCzteeadv/gaUB1XI9NsOo+yfunSCP2UKVlwZfmq9l+yQWlsNtT
	 5FFPUk9UDXdMTc9Rl0lfrIjIBhi3gRVItYHTsnkr60OEBtS7SiSl5yljnhVqTKTfimNYb
	 yn/XPbx/N9O6CP4ytLJu5eKdxSgbLUPdN15KStH+q1WQy3sv88457wkEAT9BLQoJIFa2e
	 3O5E+MABx/3n41y8/KBrmwI+aGB4qPMlxtv2kZWAUJjmVderjGvkGJDDSiYNWIKNxZmoI
	 FOc8N0nTLjAr/mg3OQdzKoZrG7BmwHiJeEH71bMuGPMEgOZ9Qj067c7ojRZb8hkdsYQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793723558;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Received:X-Forwarded-Encrypted:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type;
	bh=NR97qxa1tJCk8/3NXh8u8lLXKz57p0plaZ3QiqfzgAM=;
	b=LfeG+wjRgHige8QYZro4Vw6rNUGj8biyNCgcUd8xiFqZFr60SVmqL0aPF0XTojxvF0dH
	 AZ6SBqgeSjdWUeNCZDGCuaNKw0Y4BugscYvTc8hy7UMpMfujAtgTGajfNYTAZ7WY4QaDl
	 0/A1IJeHPpHtzKUMXqTTxRJ6FsYpnwJdtLZHeZCYk09KzlRyYyCeRMDJzLmJGJeHgWDyu
	 l1hROy7B4+gHsvJ+unwftkTzzxcqJi0PFlkLaJl28RZVZuOfp8nTIsqV7LuOqJQ79jU/3
	 xAdW4FDzJYcFWzSSZy3KQ+BcMMI10R+bF+sIG6VzaqL1A5f0JrsTRdGe1J+6ayETpPw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=linux-foundation.org;
	spf=pass smtp.mailfrom=linuxfoundation.org;
	dkim=pass header.d=linux-foundation.org header.i=@linux-foundation.org header.a=rsa-sha256 header.s=google header.b=NUsnNKLK;
	arc=none smtp.remote-ip=209.85.208.41
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8579606A327
	for <linux-fsdevel@vger.kernel.org>; Tue,  3 Nov 2026 16:32:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B8579606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux-foundation.org header.i=@linux-foundation.org header.a=rsa-sha256 header.s=google header.b=NUsnNKLK
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-6b3dc272dcfso5863779a12.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 03 Nov 2026 08:32:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1793723556; x=1794328356; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=NR97qxa1tJCk8/3NXh8u8lLXKz57p0plaZ3QiqfzgAM=;
        b=NUsnNKLKOePlKXN4jT6hNenylcyazMQW6qj9J0Cd34LQtTtdXPrxyXgEC5tmM5S6qb
         czgvpGDq8b3N9veAKtavCLmDGw4ngwVaKX1enSeu8Tr/Eiuv8IXZWvYRstAispw7Q07I
         /GhRpHnW3iFQu7nTFXumS6rADd3JgwE5qVId8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793723556; x=1794328356;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=NR97qxa1tJCk8/3NXh8u8lLXKz57p0plaZ3QiqfzgAM=;
        b=A5unpmv6k1t5HYueqfScdKdd7HkNSrqNlnwptgNu5GOjbVLoFDWUOCS1DQLpoPqC2s
         kzf1ecxPQkKPvoErN78X6HF2oMRIswVY/cjwcmAGWLmTo1iJYWVvR2OWstcrGEerzSb4
         QPi7ztT9NL/9c4kGLbeH0TyLUSDJRL1bv3ztXg6Xt1ywCvtza2Lx6ac7aHdBuBBvmf8P
         NcGLEo0+IXd+3ZVWnRdUuA3LH+kcr6YhGuCl4PNV34HXkfh01tyalmTfCTaC1bECiO5K
         Q45c6JMHT7XuwHxh8DBQAfFLwNCQBvrEAhnQJI9jDFrPy9NQ8vZAEwS40rYfbCqUyK8S
         OzSw==
X-Forwarded-Encrypted: i=1; AKwUvByFyTnHsdEcEi0CS438d7EobJarWRhm90czncJz1+b4FcdU0jIHSeHsiMACjyJ51DJ7sDBukEduGRcWsXUR@vger.kernel.org
X-Gm-Message-State: APuU4Z/j+6P9Qrsd/8F4HE54MPZCK8uvDye+LgaA6x4DMCB30/aQUHJb
	zHNpse3i8XyRz6mpFpi/sq7H+p1RZAuUIOoCV8xQ3u+XmlvvuVjzSP5koKwq5NyDZYetXMvrrGl
	YFHUsafV+bQ==
X-Gm-Gg: AYBFou19k66iIm14CpenknKumykQc2LmmwUPfPkbLO0ngBkbk/U3UHvGmqjVrdi6iR9
	P4db+hWWBMuaiK36abq0MgCijghKygWTS7I2kJeAAl+6TtUgeXk7vAE8K+MS4ePBx5oO9/CFkXD
	ANRwzJqpDxb8S8DnBI499ZzRRK+aEpjN01stTWLmoQ8ywSY+n88OOLXfdEGNaLa8C/p3f9w6z6r
	1o69aPz6UXnszxj1V1bmthvZ3l1JAmG4+MCwbuTZ/uqYS6WVsH7wNibbQ03ZoISfy3h2VONp6OA
	FZP6toqc+gdgVGRMGiLaMGXqXgRJc0A7KPDn0wll8Ya3FftYvXlD0axgqb41ro16L6lXizHjYsW
	R3Fzzf67Y3Z1Qcwxkq+MCq/2iiJCurqxd8c5dYmnxGx4ViVXRqIhYEofsjKfxB2P/QVQ3s9C1EO
	1BSnKe5f+MG+b31En40uG869ZpsJH1eNcXrpSq9Tda2gAf7YSKer37ygA3tLb43xrlfckYD+UvF
	jrlf7jbVzuzjPsjerKCjwhh1VLZ/WZal1EiGCbeLCTgUcJcp0QXc+AedLNC5dNCchCxPNi4NGB6
	n8iqLaJSbjFLAxM12ZjU1vmQgCmKJ/RpzA1TZYODBWtRTcA2VEdRd7lKObPSjwjS9lVuq7w8Nrv
	C/w==
X-Received: by 2002:a05:6402:a303:b0:6b4:329:109c with SMTP id 4fb4d7f45d1cf-6b4d3392457mr6996778a12.4.1793723556001;
        Tue, 03 Nov 2026 08:32:36 -0800 (PST)
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com. [209.85.208.45])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6b4ec9fc668sm4408547a12.15.2026.11.03.08.32.34
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Nov 2026 08:32:34 -0800 (PST)
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-6b3dc272dcfso5863716a12.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 03 Nov 2026 08:32:34 -0800 (PST)
X-Forwarded-Encrypted: i=1; AKwUvBxbBPXFcqCtYyuVmwsf6qDlDLZHzBbtdlRMPjp7OP6leED1pzpMxw5ERSouIT92LkQ/cYJx1PWhaVGFuTfZ@vger.kernel.org
X-Received: by 2002:a17:907:6e93:b0:c41:1e13:4ba9 with SMTP id
 a640c23a62f3a-c4ca795e46amr1177918466b.6.1793723553776; Tue, 03 Nov 2026
 08:32:33 -0800 (PST)
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261031095716.3030288-1-amir73il@gmail.com> <CAHk-=wiPhTLn1p0ZHx-7SMdk4_zazqDK1k7MMEn9scRfqeDgtw@mail.gmail.com>
 <CAOQ4uxjNrdxZdZZipsqnUNq+TswCKqp+30iKRKCqh2WOQ-zKGA@mail.gmail.com> <CAHk-=wiimdwWu0EVQdxGVjbVWdzNKGg0f6vZ1aR-GXxDvQa-Eg@mail.gmail.com>
In-Reply-To: <CAHk-=wiimdwWu0EVQdxGVjbVWdzNKGg0f6vZ1aR-GXxDvQa-Eg@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 3 Nov 2026 08:32:17 -0800
X-Gmail-Original-Message-ID: <CAHk-=wjz+Tg3iq_6uBqxm+egP_aRhodcz2Qu3pQaR8SQcvPt0A@mail.gmail.com>
X-Gm-Features: AclHuK9w4S2wxf4udVRHX01W-WMPzHWb6oB-n8uxW69QasJSfANeHRc58bQ4vhU
Message-ID: <CAHk-=wjz+Tg3iq_6uBqxm+egP_aRhodcz2Qu3pQaR8SQcvPt0A@mail.gmail.com>
Subject: Re: Return failure from take_dentry_name_snapshot() (Was: [GIT PULL]
 overlayfs fixes for 7.3)
To: Amir Goldstein <amir73il@gmail.com>
Cc: Miklos Szeredi <miklos@szeredi.hu>, Christian Brauner <brauner@kernel.org>, 
	linux-kernel <linux-kernel@vger.kernel.org>, 
	linux-fsdevel <linux-fsdevel@vger.kernel.org>, overlayfs <linux-unionfs@vger.kernel.org>, 
	Al Viro <viro@zeniv.linux.org.uk>
Content-Type: text/plain; charset="UTF-8"

On Sun, 1 Nov 2026 at 09:16, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> I'd like to see an ack from Al / Christian, but
> I think I'll also rewrite that function to use guards.

I didn't get any acks, but I obviously did do the guard rewrite (and
then some: I got a bit OCD about it).

I've committed the end result.

          Linus
