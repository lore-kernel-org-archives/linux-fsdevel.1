Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D807352C34
	for <linux-fsdevel@vger.kernel.org>; Mon, 13 Apr 2026 21:17:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776115052; cv=none; b=BC02SPAxtYc3C9HQ4m/RLvxJa7F5K6aMdE3zN7CJV2TF6mm0lVDT3AIqIzALWzBHP5HjAmV5oz2a5LmRbycuADeAtvB3FgRejAkGWKwfZhhu94V2jqbKhSh1m8Hrx1X7pBfTAL2Cy+QY+weUsoCVT77CJxyw77cR6+b0hT7h/jA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776115052; c=relaxed/simple;
	bh=jjz/HhUUFieDVgwHDlcrtbhigzZK/gco/C11DgaIWc0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kNEGokf/GlOHl/Y3lETJNfYthvRpoZvf7xDl0PF5K6HJEsGKyNx2Dyq8Fs98XBo2LUu/1m6UYQT9NcK9h4/9Rliu7C3ry1AtiyH5TSyJg4Q4bZPCOh0WP/hsCYidE1VzAHhnErbDvJhptq5owqjLtk0hFyMXMdFSEWBBk9/KtQ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=IkjzZXPq; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="IkjzZXPq"
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-b9c603ec2dfso650760266b.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 13 Apr 2026 14:17:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1776115049; x=1776719849; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=9h2gDyNayaY45W3DGBdN37EYfSKihLPqKo+SOpzlBEQ=;
        b=IkjzZXPqoQyxpO3nbR+L4//0dGzR9rBF3D9qu8KbcHbITViqIkDXRbUGbOqhgZQqGI
         x+4taBDBrM3QO7vx2V37w4LJ1cE9+82yg5BNwFM3Vfmq/wJIX3BwPFogwmxm6mcLGz8D
         r3oYitLjLm/H24sdRLy1ZyCBUTpliaImpB+VM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776115049; x=1776719849;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9h2gDyNayaY45W3DGBdN37EYfSKihLPqKo+SOpzlBEQ=;
        b=K3EODlrPyjdRFFlLgzQW2/dDkEdfey52T4AZ/+QEDhlA3qe3TsOJXGJt5TUXhQaGZC
         OO9H2mxKyXFe7AnxyRPDYwUeuLaYr011Rpoi8UhHL45nRbtM4/lFfwFDq+ydmjkocm0m
         25h4F1G5jZghss/640EQL39QlbZ+mCVGz8hfbq4CZfITN7PPWGwPKIhFNlxIK8aVCzwN
         uT6pJklSP3EpwqpxrXnxGSWhPA0SvGPkvSUcVlNL1/rMRvBqEOToycL3UKFjG3p7WHOm
         GgAUpqytNhwmV+oWWuI48ZPjhTb86361HxxCAC7+JKOJArnJHjqgC8KEAa7HDkmaXsOO
         LsCQ==
X-Gm-Message-State: AOJu0YzB3Wsfju7pE63+g+eNqvoqcbGkNtWbS3dq49H3xXe7i4GOiZDw
	WrFZGGcVWOF2irhRalOW+LflRUR54Wq7Zt0dMt4tS4KrJZooILqBUYr8m0K1obj0iyzAqmFX9ez
	X+Pbho4A=
X-Gm-Gg: AeBDievj3Ha2TS8P1BUkmm2nVOdMEzNdMUB5LNOpzLuU6lO73lENrZysLcdi74Krsb9
	qOYETaAAiDtjJdMPIx5nDuFZAqIptiMQpkwYCGNatvXyqxrM4I5DlloWgYpbkJWgp8pwCJVezkO
	lawFix31mAxuXCyPtiu1CS3oWsBVliw7MGsr1s/sgCriFO1ye2z4SmnVj83j/h9AzAANoMuFH30
	ekg55qHfR/1SA8CKyrjZdpn0RXKVX5vJU2yzhSDWj8RKtFNnx2yFXaogSGoo2T3NMFWZujdu0Ec
	7ppXllXFTdSQxdHdpbfS2DU71tGonPQpAoYhSWI4P130v76uAOWCQ8HCHIpo4Xte+PoQvauQdmk
	Dh+2Uhwiacs0+TKkUdr98R1pBIGujBK8g0Njn4RPRXWEqSUuJoSYIiBLG7+2Vit9j/r4S/yKPFO
	irxkLLciDi8vRRLPW8FZErh16sLWMTH9JlCUUV2IIdl/5Fna/165dqY6hQjL8PrGgFTX5UFT2G
X-Received: by 2002:a17:907:a806:b0:b94:cfd:f37b with SMTP id a640c23a62f3a-b9d729cba9fmr847666066b.45.1776115048610;
        Mon, 13 Apr 2026 14:17:28 -0700 (PDT)
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com. [209.85.208.53])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b9d6e7f1765sm330601366b.56.2026.04.13.14.17.27
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Apr 2026 14:17:27 -0700 (PDT)
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-6708cc2d6f6so4975649a12.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 13 Apr 2026 14:17:27 -0700 (PDT)
X-Received: by 2002:a05:6402:4343:b0:671:df5b:5394 with SMTP id
 4fb4d7f45d1cf-671df5b54bemr189227a12.18.1776115047594; Mon, 13 Apr 2026
 14:17:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260410-vfs-v71-b055f260060c@brauner> <20260410-vfs-mount-v71-89e63a03df4d@brauner>
In-Reply-To: <20260410-vfs-mount-v71-89e63a03df4d@brauner>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 13 Apr 2026 14:17:11 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiA_XzFe_YswO4hezv7MQH6D66k-MBWEZwFJ4urut1aJQ@mail.gmail.com>
X-Gm-Features: AQROBzAQACdJ_gQflq9FRL8Z5UcPmn-JycQ0sjLe0GGiRdGdWlhvYVeqPmrwAW0
Message-ID: <CAHk-=wiA_XzFe_YswO4hezv7MQH6D66k-MBWEZwFJ4urut1aJQ@mail.gmail.com>
Subject: Re: [GIT PULL 11/12 for v7.1] vfs mount
To: Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Fri, 10 Apr 2026 at 08:23, Christian Brauner <brauner@kernel.org> wrote:
>
>   git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/vfs-7.1-rc1.mount

I pulled this, did all the merge conflicts, and then at the end
noticed that you had merged the broken audit garbage into this branch.

End result: I unpulled it all and I can't pull this branch either
because it has that broken stuff in it.

This is why different branches should be independent things. When they
contain each other, there's no point. One bad branch poisons the
others.

               Linus
