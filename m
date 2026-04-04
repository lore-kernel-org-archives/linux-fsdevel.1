Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75309322B8C
	for <linux-fsdevel@vger.kernel.org>; Sat,  4 Apr 2026 19:05:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775329503; cv=none; b=JiMw1Jgjw3EKb+BoUd5WCpfj3o5C9ITGQBbVnW1xW7jn3DeABa+6DW/zJetDZ1BT+18vfg0svRQidc69zMsql4BQ5ASsT4snDvmA77KPAW/4WPy0NCDGXCUruPHwOVYefzVZ66YV0YBlVOLQzVHCFie2QvUs5oSa9hqPkHyh7sQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775329503; c=relaxed/simple;
	bh=g3AjMFL4KMp+2MuiULI/d3GRWWnMFs2jZnsqQGc17d8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MoTfNMKP0/Q28iUeCFV/E0QvjMUrXJO2BF5HLqkftTl/31wXB0LLb9xqSogpDZ8V4QvQY4Rze3zvqrE3whUxEwbq7igFRRM3aXZJNbIpNYpIx4GAVD5U9a8vu3ZYG4yxBviA62KbkDdzbsiAXsdiJDLGuYTwjrDFpAlECNeIjIs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=O7Ymd5n8; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="O7Ymd5n8"
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-b980b35534eso619810266b.1
        for <linux-fsdevel@vger.kernel.org>; Sat, 04 Apr 2026 12:05:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1775329499; x=1775934299; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=+dXe0i17fDcazUcsWb3eStu/HsE5jyVOvRkZ0V1VWbQ=;
        b=O7Ymd5n8/KS9olYMKrXHhiD53DuA+BASX32apuY/Z1T4UndfRbEJ3emGBVZBgEDuus
         RoNpys2dKEJHVcPnWo82CtmwYuRymkuTz1qfxYJTsp3k8S+Jge3pMJIaFihMEVACSKNL
         o05YfceNOjBoOtnPkQjW5oZUkQrSb2GQ+5ZeQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775329499; x=1775934299;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+dXe0i17fDcazUcsWb3eStu/HsE5jyVOvRkZ0V1VWbQ=;
        b=WRcKpK/rzo/PLrxmPEbZ0nOFNgfZ9OL5d6QjXq2oLZEqTqLoju8LtUZ5lDmVVJ4lqZ
         Hm3lMvZfX3uD2zNVVb/46iZyfnUK57oiA6mdB27be9TjXmwHt0LpciWbgRoPtd5BhVZL
         H5aGi0XaHmdwY5e56yg4I+MP6Q4SaYpDkGZyrHQEziKOFmp+IGKLTjpFjRr7iQ9FhNOs
         hqcCEIwVt9VT6dLWc0REFQ6KWS3uc/K08XoW8eO/wUL2PvQEXbkygi5BG2+6IAWrfSPb
         VjC7+0MsN3sCcg7IybtJWbtvp/m56OJdrgGfje5XMCwmMX8paobARgLWB3MNTghj1w1S
         yhDA==
X-Gm-Message-State: AOJu0YzEXFlz4W8d1O8yiYA1eDHz3ggMG3jn9rFNGWODoNVncgKxRDxc
	Z888BfK1+5+kcWHD13lXQUlDxHlU+4fYcFC6M3pmczx5bnNs2mC3aWCZZ1doGCzjuhgC2lfdVG+
	ujkzQxGk=
X-Gm-Gg: AeBDietTMvNJQI5BL7rzFglSDIGkqzC+hNPa4USkMyuEPyD3uDEasgDifuea9AqjE4j
	gd9MAUzIg73qju4QJZFzfiFNroVuSJDxjhyBDYw9H/4dhWRSXIVEBYjEosU9fCIuVO3gX1GnMwy
	DnDUwafDBfSJnwK8oL+C0BN30lgPs0ys9vUOx8D7fGqT+i+06+GPH3tYzbf/8hAdjUfuOqcPJ6C
	YP3o6JQ2peJhFm7sjA0BB2m1HJ6E9vg8evYDzo0NhOR8MT25KnYoCh2cCCvvriT3QbIB4pLVC8U
	+Fvu4Q1jVGcP22sEuHfwHJETFmI8dtZFrYdD3tjweQ6OW1V0DXupNo8g+HYj9510AkbAVHjaEh7
	+CIOoQuGHE0dmUV5U+Ox4RAKePloAJuI/dhgtqXOoa73LMXARW8r79IqlLZQEBpgCG6M7YNbklD
	sOpydDm53HQOvX9ZX4s2a7JVfmWcTcqG7TQ60qlM4RqfumSg3iWP40mRKzml8t1keR1DLnRhcYP
	LD8jdVVT9c=
X-Received: by 2002:a17:907:d78a:b0:b9c:30b8:dcaf with SMTP id a640c23a62f3a-b9c46de6945mr607866066b.5.1775329499339;
        Sat, 04 Apr 2026 12:04:59 -0700 (PDT)
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com. [209.85.208.54])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b9c3cff1298sm325562066b.54.2026.04.04.12.04.58
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 04 Apr 2026 12:04:58 -0700 (PDT)
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-66d65646c65so2165653a12.1
        for <linux-fsdevel@vger.kernel.org>; Sat, 04 Apr 2026 12:04:58 -0700 (PDT)
X-Received: by 2002:a05:6402:26c9:b0:66b:3c98:6587 with SMTP id
 4fb4d7f45d1cf-66e3e61f3d6mr3111075a12.14.1775329498246; Sat, 04 Apr 2026
 12:04:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260402180850.3729310-1-viro@zeniv.linux.org.uk>
 <20260402180850.3729310-5-viro@zeniv.linux.org.uk> <CAHk-=wjR66-0qL08k9p10Lt9vuvmddFT5WvfnG+xXf4Xv3-VhA@mail.gmail.com>
 <20260402224439.GI3836593@ZenIV> <CAHk-=wg7O-p8L7384myYTus6NH5aYdoS=y=+iALL_8DLT3=ZLw@mail.gmail.com>
 <20260402231643.GJ3836593@ZenIV> <CAHk-=wg5HkyPCFsfXS6u2xe5h=dV5WT9zaeqt-fRQyE+OxKGYA@mail.gmail.com>
 <20260403021522.GK3836593@ZenIV> <20260404000200.GO3836593@ZenIV>
 <CAHk-=wj+4igg2oOydcfZ=yqAd8MW_wT4db7SFtPFOsS31rnh8A@mail.gmail.com> <20260404185442.GR3836593@ZenIV>
In-Reply-To: <20260404185442.GR3836593@ZenIV>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sat, 4 Apr 2026 12:04:42 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjfwM9FKpa37uvH0c1Bv_VBcuU0jMRAci7Oue=mw5ZXaw@mail.gmail.com>
X-Gm-Features: AQROBzC-EE3BU2VIDpixt-1oP7-68QW93HsjlmcXFyJr65Cb257-6kRPAlrpZ5c
Message-ID: <CAHk-=wjfwM9FKpa37uvH0c1Bv_VBcuU0jMRAci7Oue=mw5ZXaw@mail.gmail.com>
Subject: Re: [RFC PATCH v2 4/4] get rid of busy-waiting in shrink_dcache_tree()
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-fsdevel@vger.kernel.org, Christian Brauner <brauner@kernel.org>, 
	Jan Kara <jack@suse.cz>, Nikolay Borisov <nik.borisov@suse.com>, 
	Max Kellermann <max.kellermann@ionos.com>, Eric Sandeen <sandeen@redhat.com>, 
	Paulo Alcantara <pc@manguebit.org>
Content-Type: text/plain; charset="UTF-8"

On Sat, 4 Apr 2026 at 11:51, Al Viro <viro@zeniv.linux.org.uk> wrote:
>
> BTW, how much would you hate something like

Ugh. This is your code, You'r ein charge in the end.

> static bool d_deathwatch(struct dentry *dentry, struct completion_list *node)

This looks odd to me. Particularly the "complete it myself" case where
you return true. and then shrink the dentry list because you *think*
you'll be waiting even if you don't.

IOW, if you go down this case, wouldn't it make more sense to have
d_deathwatch() return a ternary value,  and have a switch case in the
caller, and just enumerate the different cases?

But I don't know. That's really more of a "that looks like an odd
pattern" to me than any kind of objection.

           Linus
