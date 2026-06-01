Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 758B125B080
	for <linux-fsdevel@vger.kernel.org>; Mon,  1 Jun 2026 03:11:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.171
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780283510; cv=pass; b=s2yrJrCgSIlHieIHeB2eC5mPfE6zZ91tQxQBbN66oKNzVEQ23p+t1pV5p8bhY0LJe6U1aKhnyOQjF9nJbYbPMuhciWFiX4APkpAPX9S5TrEdJDI58P8BukBqihj6t+xWvN6pJJ14e40HXYjGptV4r7sdv6S131homOsvYEI2hTc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780283510; c=relaxed/simple;
	bh=3MMmkUu/YfzDJCqhb57EOJIut04O28w1bNQaD8zFkqE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=q62GkQPFZ+DYu/znyqyyHT91YhKUaNyNtGwMKKnyxn4zd7Ue57bd4zl6Vs8AdZAAkqTHvP/eWlNEw2r3eAJ1/uF/HuUy5wbsMqxf+ykFhlqU/V5akxjhUJIi0sf8JGJCoYTYrfyaPSq1KaooJvx+v7pOUObq0bk6M1Pe4sG4slU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amacapital.net; spf=pass smtp.mailfrom=amacapital.net; dkim=pass (2048-bit key) header.d=amacapital-net.20251104.gappssmtp.com header.i=@amacapital-net.20251104.gappssmtp.com header.b=Gr7Xked5; arc=pass smtp.client-ip=209.85.208.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amacapital.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amacapital.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amacapital-net.20251104.gappssmtp.com header.i=@amacapital-net.20251104.gappssmtp.com header.b="Gr7Xked5"
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-3966c0d5ac9so13071181fa.2
        for <linux-fsdevel@vger.kernel.org>; Sun, 31 May 2026 20:11:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780283507; cv=none;
        d=google.com; s=arc-20240605;
        b=LjCLazJNsSHR3M5sQVQbod2kd3ZY3CZNODMSzllltI+1Fb0j54L5FEZ0spvngwQ+Ij
         pNJWjuyvZyLNtPV/ORciVctzCKlcNgM134xyShWEuGIymqBTdtT0xUAGM0GHxcYA5VMn
         QiP2CpSEnwQhWArtfcyb/JJaKYt3cFEFfsx2djdwpAdEUjTnKnk8y0xhOflvRv1xpyhO
         4ysZGezTbzkq8xYrQvhDDrIWHrs+ophbQhEmPSVgWH9sKBNuxcnq4n09S9VrMUWuaJJd
         h6GE3uoBx3qHTcRFQ1pqGiL1k8sivLuzXohWq7MCJ90AF9r399BeXuX+JgZsDDeW/tGH
         9XMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=MuDntok0/7oP3h0HaSkrbvB8I/WbSdzhW7ajx8MOkQs=;
        fh=rsjM5un4HrOmnQQNTq/1+QRybwP8hMBG1qEeyCVTdfw=;
        b=QTuWf2vSKZFyBmzxA/QzUIVtth+mCzbw+GfasbEq2QVfgK9Z6MPg7E85Bst0vov1bq
         ucABUVfwpNzZntWzBjxGDq/bIeDYJ8SHIfd9on9GscSmjJFDUEilsKCI92lbSptlZpyT
         zsuG2qpSLx1TMNNi1MtBwBRzAhcAdeaMSBg1Ich/7q7Z2w0fzLbadZI4AtdQXElhMnoz
         HmoZAbv7bHQIITdwzWRnx4t1AeF0IHlYWQUXU09+paGBHj7gnFkoScCgAli7cRfKzqTK
         yCCQsMb0TY0j3x/eeOJYZNaeA9R4t01A7ioDMMPqXE7nd2V8vUeR+dj/jgoTrWdvVRId
         eZ+g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20251104.gappssmtp.com; s=20251104; t=1780283507; x=1780888307; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MuDntok0/7oP3h0HaSkrbvB8I/WbSdzhW7ajx8MOkQs=;
        b=Gr7Xked5yR/ormdg6QmBhuz2EBqlCzpWBE2BhBmhSBdzCgihYFsbieosgEIPjRtYD+
         ivgvFTq4CSNpUsUQfk5YijQ2OhavjVJCtbNEmPdBcxfYB4r9MB7bJxV7MMwh+DZYFFpp
         v759H90t+ReadfkRDLe8WQfybeejBFfb0QVybNh/KNGzJkgBDjsHezX+0TqVCNpe8DQi
         w26QmkJ70iQcFPCcXPGdm4trE8B6SImrK/2uvsMQS/OrXUflXJDvOdwAnd+cAtQ8Z9Ki
         vhTgzaJqws6ofLXjpCx3uynsdQnCr9TQ6rF2xezjyq2kL7Y/GZXQQvO721TkWqmtat6s
         WEZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780283507; x=1780888307;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=MuDntok0/7oP3h0HaSkrbvB8I/WbSdzhW7ajx8MOkQs=;
        b=W0djckNO4Tw0yFdxVzNQEXR1IgUvN94vSthJlXD/lAVhf56ChVsmRjZ4ER5Pw+/v6N
         kco30PB0RIzBmwyAgctoHOj52GrBVbLBfWxNM9wCkYKKJmmmL+/NzyUPJexhfa1dzkrE
         9bZZVuBbYkjEDP5hZ0lXs1VoFaqbjmBIdh/6HDFO68pIouRDhJ8eC1bFE/ciVx/zHels
         3NIp6xyrm0R0WBvC4fbXAQCzSmySiD8ePmJcLzOrsqOux4ZU4jYhTpURjunsmXQq5SOv
         x+kKXGZQ1xDHojq/+QpDooJUHauXqJ128lqmGXxU5EjlRJMy2urRzIonoxtEKIllWVJS
         TNmQ==
X-Gm-Message-State: AOJu0YzZ9w2fuRXxkgjSKsKWCpUAvainSTPifP1yFKGIn2IhxYElVFqH
	ZgiWsAhgvP9ow60qCBdd49Mu0OnF10AOyIryU/oddFBBK3+z2y6O1ECaWApyq1UWEH2aZJZEOca
	NxgFqcFUA+51E7rz5dYPcgkYLLH7tKFoKdpG2h4Oy
X-Gm-Gg: Acq92OGhpECjtpkEr+tN7SKvDW7cm32OX0v1oXcldxRD9V66nfVHoRGb0qKgBb/xKR/
	1c1oQvjuWGYqa2OKWdQuZMOoP5LuzWuFYWOBiBFE7W1wElc800o2LRajMx2pDww4/iFXMvirQ8j
	Ny1qT6lyW98jC5zMMyfX2KR8+vD2Cm93B/27adroatPnYq8xDuMsVfRkjcPK8xAmU/WYcy23pFi
	tQA6f6ZP8FWANKPLf/y9V+VPzYuIER8jniGDQjybicTZ61r+g4+GmG9Kq4q4SM26lx95wp6/CsC
	Z6CyPNfDwMNuMUI=
X-Received: by 2002:a05:6512:158e:b0:5aa:690c:662f with SMTP id
 2adb3069b0e04-5aa690c66e9mr1347657e87.23.1780283506595; Sun, 31 May 2026
 20:11:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260531010107.1953702-1-safinaskar@gmail.com>
In-Reply-To: <20260531010107.1953702-1-safinaskar@gmail.com>
From: Andy Lutomirski <luto@amacapital.net>
Date: Sun, 31 May 2026 20:11:34 -0700
X-Gm-Features: AVHnY4JXGlP1eBaFLieX9GEu2QC7fa8YTkX6sK3P-yG-Mx-u9DLHduWiKUrWdA8
Message-ID: <CALCETrW__=8mSusayfXG7UFCfue5BGbx+vqESj1d9wqOfX4s8w@mail.gmail.com>
Subject: Re: [PATCH 0/3] vmsplice: make vmsplice a trivial wrapper for preadv2/pwritev2
To: Askar Safin <safinaskar@gmail.com>
Cc: linux-fsdevel@vger.kernel.org, Christian Brauner <brauner@kernel.org>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, linux-api@vger.kernel.org, netdev@vger.kernel.org, 
	Linus Torvalds <torvalds@linux-foundation.org>, Matthew Wilcox <willy@infradead.org>, 
	Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@infradead.org>, David Howells <dhowells@redhat.com>, 
	Andrew Morton <akpm@linux-foundation.org>, David Hildenbrand <david@kernel.org>, 
	Pedro Falcato <pfalcato@suse.de>, Miklos Szeredi <miklos@szeredi.hu>, patches@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, May 30, 2026 at 6:03=E2=80=AFPM Askar Safin <safinaskar@gmail.com> =
wrote:
>
> See recent discussion here:
> https://lore.kernel.org/all/20260516182126.530498-1-pfalcato@suse.de/T/#u
>
> For all these reasons I propose to make vmsplice a simple wrapper for
> preadv2/pwritev2.
>

I have no comment on the code or the history.  But I'm 100% in favor
of the solution.  vmsplice is a crappy API, and would be incredibly
complex to get the implementation right,  and it should be removed.
But it has users, and the approach of just mapping them straight to
pread/pwrite makes perfect sense.

(If anyone wants to contemplate how bad the API is, contemplate gift
mode.  Or contemplate that, if you want correct results, you need to
avoid modifying the memory until the recipient is done reading or you
need to avoid reading the memory until the writer is done writing, and
vmsplice *does not tell you when it's done*.  And there isn't even a
caller specification of whether they want to read or write.  It's ...
crap.)

--Andy
