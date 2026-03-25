Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 353E321CC4F
	for <linux-fsdevel@vger.kernel.org>; Wed, 25 Mar 2026 02:43:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774406632; cv=pass; b=UZByXSxfELQ03pc5TjRjqKMgFV5QufkWBZlQXd+0Cfn2TXYglis7JlCmNZLGY+pikI0+0najtxJ3Nx8yXmGzsz9KWpyPSrgA3h84EpO2A2dfgMTM2F54yxP+4dHsfJjgZ/TEqCEgpaKt0wUqruiZ2YUssOonJGCbMPAHzysjcck=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774406632; c=relaxed/simple;
	bh=fWvC2a/xqgh1OldCwgrsGXahk8JcrWhz5yP6DeSbVtc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dV7YqwnzQp2sF4SqxO+UA1zhkl5fSkJVNlIsB8D2ZqcfMtbWULhhCBmZntA5qAlYeD2YdZo9lWAooNGd1wUbjEbEE55mMnei0wcRr9oSrQHTenKPB5Tfr1nUd5QoyM0jkrVFTVDqDdmCLzJs/RJnXg2LHhS/oP6LR7NE7SCN0No=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com; spf=pass smtp.mailfrom=soleen.com; dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b=InrYOueA; arc=pass smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="InrYOueA"
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-668d41905a4so7127121a12.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 24 Mar 2026 19:43:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774406629; cv=none;
        d=google.com; s=arc-20240605;
        b=YLgUkCPQL5BiifXai9JXHaG79nT0O1lMlWPwLT4p5yMBEgEUWKSXZG9KgtgZCFz8ob
         wSFQz+J2MG5DUHc+eKX15DsupFISD/3wW7TW0oVZNkHiiAPNTem+yHxaaFllHR/rbfSc
         tigRrtnqyTfR1Uj9GBXjPhbR5xjFMphhNLLF535+g8mtvms8SoAK+fG2M8Ooy3z0hy1O
         tKHdmSKTvC8cqQ9vULe2X1bJxQyiyaoGETER22fNpomihRRi8fiU9vxEJ0LA8DlbpwHG
         4mZ1DZvDoHTkpqB6j8dgoY5w7vz92T9K5ufWjBCpqyBM4lPEGn3CSAHp8YCJoM4teMWS
         6tNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=S49Ro2Awewt8DGHII5530iVBK0Fi/44fxcec5lAc15w=;
        fh=vM0MhtcsoCUcY2KyLM65Wp84BCko0C1N/EyoTJe17HI=;
        b=ZVjOpol7z5AW0ryBCh57hL5R15/ZBQ0tjr35Of+TC29sOjvRkJXf7VnaMiXLAFHswy
         GRK1iqES6RYQY8QgHNDwoaBit88mr47WZZ7UdseKz8fZBhbaA/8RqJOqSljvWs9KpGM5
         0fMvVrtcXuOP1hO4lJjCOIylbHHsGPVgf80NOqncegrbv1LGbZf1eAmpbjxK3V+moWb9
         FGRRuKVGbVmKmX8QREyI5dGlQYDqPnRYohAXKJFWI3+zpNJnnBXC8quxcQOGTauruXua
         LJdkccr6mUaJKAomHSjOjVKTQI6iOSM0Ola9r69BAFPHUmZG7wBmEKaGpWWDRW53fzPY
         CJQw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1774406629; x=1775011429; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=S49Ro2Awewt8DGHII5530iVBK0Fi/44fxcec5lAc15w=;
        b=InrYOueAM8rS8V9B9labB28oGnLc1ZWHbERKsc+q6TxNc/2ZFvRaEJClBav/bAqUlf
         XWsMabUul7UubUDGMw2I86BGfnul3g+kmqQbyJYWXjVES7sOAXsiSGjaVlvu9iilNeR1
         Vo1YHbASiKUwgPMpEA6GcqkxYZ9KLHHgXst6hQN9LkJd4A0/xetwnP3dPztSr+jxuChk
         akn6H2lZ9OoxiPZ5mFG+H9fAjDpV7jUidzCqMmVxEk5eblGGkRetiLpCE6UtT2QRcIEd
         EqTDcAnU9O4OIukDmf8rPXQqr1UMyn8/JSc41BIIFTlqt3j2Qne5srE+f2A1WpXVcgs8
         QjwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774406629; x=1775011429;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=S49Ro2Awewt8DGHII5530iVBK0Fi/44fxcec5lAc15w=;
        b=NXOUKmfaO5gkQPgOvsUmePasRsiwy2g05iTLd2MHSkPWt121GBphgGSy1sy1UuDdJ/
         lIS9mYRq4mJZVQsfdQyoaMBYryrpk5ySWC5SJ0d1qIRLAVNhTqnP/ESsPBz2i6ezv6hR
         IAVuCbQzl3/8xv4IVliM4oBr9/AVEesKc9jbwuEUZ/ErxlsFZJRBFoNqtut/MnLH8/zo
         Nob/Rvmalr4/6a2E3THVGAYpHrdPY0kvGog8TbX+w/FjXvBsoX+vZn56BtovU3dx6T3N
         e2vTJXUPQrOKespQcVJYiJDAxHIzxI9332sw2YU9XQZ6/oUCDqmvKRAALQqnEpWny5wL
         kmyg==
X-Forwarded-Encrypted: i=1; AJvYcCWo4EicCvR3bvjTkcTBwCs8TQpVXxzzYuzKHqt1RNhZ0mwVFAKn7JDHhaumY0BWDZsPzRSc4kr+k9SHewQO@vger.kernel.org
X-Gm-Message-State: AOJu0YwUdEYSKa5guVIdvnT0F5wN+LWmA73Tqnj3+koFop/UMs0EeRDa
	aC0k9XqxwJUbUAujse17sS7Qh4AaPNCXXS0yo3SkrlFhKnFpEnE41AeZEH7csnUCq55zS1YRO4E
	rr8CZAYM1lAAOaDU8BGciqAh3ADuaJFJFttF9BtjN6Q==
X-Gm-Gg: ATEYQzz3nNCb5mthR0QN1ARBlh9k9FTzv+r0lhCBo3uptXd42yW4Bqxtg1IEeOfxG3K
	XVLLB5Hr3qBazs2Xzu5vbrY1++rrJj0NnSCdyDyn8dGD7NeaqMKEHIhDEj7IA00RbnqB4tfi6Cx
	4xiDaKWvD91qms7xJuce852SmRTROFFQeiCZMb4Va4sDxaBA95HOwuq1/fKSLFChySNLIylZLlf
	qX9sTJcDDgJK9ugXkQIqFE4L1M3O94krRgr1NuPjWOmm67x4ryzFIuWa8Ux3TlzENgd06qQxMYG
	PWv+B6mCI3s0cz6I3mBRbFKW5Y9yv2Q5wL1fsA==
X-Received: by 2002:a17:907:6d19:b0:b97:98e9:1b17 with SMTP id
 a640c23a62f3a-b9a54254cefmr104541966b.28.1774406629257; Tue, 24 Mar 2026
 19:43:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260321175808.57942-1-pasha.tatashin@soleen.com>
 <20260321175808.57942-2-pasha.tatashin@soleen.com> <CA+CK2bD2aNu-NByET4KkBP0n2j8WQE2zjxb4g-1cv2hYfjaRZQ@mail.gmail.com>
 <20260323-leibhaftig-blasinstrument-58ec408b3c40@brauner> <CA+CK2bC6S7pFCYR0XS1ZPxw9HKjWgxy=0DkszYNjMUi735o_1Q@mail.gmail.com>
 <20260324-langzeitfolgen-altgedienten-ccef17d19349@brauner> <20260324114021.f5546d2de5b6a2b0490f63cf@linux-foundation.org>
In-Reply-To: <20260324114021.f5546d2de5b6a2b0490f63cf@linux-foundation.org>
From: Pasha Tatashin <pasha.tatashin@soleen.com>
Date: Tue, 24 Mar 2026 22:43:12 -0400
X-Gm-Features: AQROBzDD_dN5K67m768ffew-lTTbV5PIJ8L5d861vCwJTCIzcd1-cpNV-0z3o_s
Message-ID: <CA+CK2bCbgXHnZ0PhzfKE=NkykyqMKq6KBXW6JqMpq2R3k3RXDw@mail.gmail.com>
Subject: Re: [PATCH 1/2] liveupdate: prevent double management of files
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Christian Brauner <brauner@kernel.org>, linux-kselftest@vger.kernel.org, rppt@kernel.org, 
	jack@suse.cz, shuah@kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-mm@kvack.org, viro@zeniv.linux.org.uk, linux-kernel@vger.kernel.org, 
	dmatlack@google.com, pratyush@kernel.org, skhawaja@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 24, 2026 at 2:40=E2=80=AFPM Andrew Morton <akpm@linux-foundatio=
n.org> wrote:
>
> On Tue, 24 Mar 2026 09:51:34 +0100 Christian Brauner <brauner@kernel.org>=
 wrote:
>
> > > > So, I'm not happy about I_LUO_MANAGED. I don't think we need driver
> > > > specific stuff in struct inode and not in i_state. Track this in th=
e
> > > > driver please. I don't want this precedent and I'd rather have you =
get
>
> Well dang, I just merged v2 but Christian wasn't cc'ed.
>
> > > I am planning to use an xarray in the next version.
>
> That's what v2 did, and I_LUO_MANAGED has gone away.
>
> Christian, does v2 look OK?  It's at
> https://lkml.kernel.org/r/20260323203145.148057-1-pasha.tatashin@soleen.c=
om

Yes, v2 is fine. Here, we discussed about the previous approach, this
is one of the reason why v2 exists: not to modify inode, and also not
to rely on inode being different for every preserved file.

Thanks,
Pasha

>
>
