Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67B53379996
	for <linux-fsdevel@vger.kernel.org>; Wed,  1 Jul 2026 04:01:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782878485; cv=pass; b=hpsPsG1SvvU66wJM9ecTsclsbqgtkXKYSZF31xW1/zm3mXYCaFQ48LxQdLUHj6jbzkoa+z9zAzfK3m2YngQPiFJQ4W1Z+VmTgsx9+T5mhiIhvnOjmoR6kpM7+wdLJMA16nnjqPvGxslREXEOWctsWw9qU9JyLcHsm7mIzkzRkuE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782878485; c=relaxed/simple;
	bh=nbcaEzsRX9Wd5cutUSGHKNyzPWPZ9Pa/dME/ipm/wTw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kDztPpwNzULoMJ6ZFd86sdqOMQfRdrm5M9OAHqdVpl2q/K66D5uTaDe5Dt/4dGOqZyY0jJEchAmEk1Oi+MptBS6rHIoPM8/LKqqx6WnFi/YOgfYi2pXosGf2SWtNVr1PuFJ9705KvyMOJQjWZhmVcwv09qTRnUnhcPaZLzVCJm8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T+TN43gB; arc=pass smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T+TN43gB"
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-c128c8c7a76so40625866b.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 30 Jun 2026 21:01:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782878478; cv=none;
        d=google.com; s=arc-20260327;
        b=qGaUEekRRTXycgC1EF7fZ613rOLXPo68waHhbfRq3p0We4+KvOPnNfyfnnjEqf3KTd
         k8MpATHX5oxOpmlD1VCFl6CjHiHLqxzQGnM7foJal3S1Rvr1BMDOHYrEBC3fqf7BNqT5
         XsEYMSE9tmxeOWsl7x6arKOhyWtMq7mj7u1xduuBrTn9Xmv0IThocnU4zPQ5k8z3d8p1
         DCYll/TmTbPa88CksjUlifEaC1LVFcOHiujKQRskkK9WKEF1gQRzySjPtBm1gH7WdhJd
         vtyOnH+JmpxG1OhhIIs97u+HDJKX9nuxLg1eV3Xw5J+Q/n4u/0YnAf6XyfK9sFCnzPog
         QlPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=nbcaEzsRX9Wd5cutUSGHKNyzPWPZ9Pa/dME/ipm/wTw=;
        fh=T1PC5SJ5dBuPH6SuoGGMaWSLzu+HnABbr3yEVnU/358=;
        b=cI3zQOgO+iL/c/pVQUijMQcjcBKqN+nbYEUwWbry6NAYd3gqInxjg4QVt/wOT2CONZ
         Fjo45FfV5rdeh9CKKHpk45AZnYJGV4ps01cNMsfqw9CyAILGnmUG/5aK2Ee3EXtyvGNV
         02GGGaEDB8A9xrf/FiGYdmp7Dx2gpaUpr2VC4pJX3JHqI4yl4ibZjfKXc82Xx1gGdu7o
         ny/QsaEd+1M13GXqnEJvegnocem+zWFJG6S8KrHmO5xENBnKl8DL/TNOZgYXfB7aWNPj
         PsCKCrsANkkfZ6ff40F6oiYhBhbsW3On1OdPFvNOTFugoxB55UJ/0SCXxDPgWgaxCbER
         Yu1Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782878478; x=1783483278; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nbcaEzsRX9Wd5cutUSGHKNyzPWPZ9Pa/dME/ipm/wTw=;
        b=T+TN43gBQVKrBdVmq3uBpm9OUZnWTc73cJaWcOQyH2zC5IFTKsqSbnW459D3TOkP1r
         T85xFxouLO0ID5qQP8ltAvZFmnSP6R1IFhEKTp8CRE4apE2+G58EGxok+Lpu/rvALvXB
         wzTm7KHngZ+6esh8D4Q778IWDHLYa25cITYjwEJ7J1pcHQPcE6tMNHobsAl9NWE9MyrX
         AInBI6vTtramaQ6gDyatXRPVXYy8CPL8qz9Sf2EmTca/0FX2qTBdP4UhiBrOWfdOdOpd
         nPnaLf7+jVMLQUt3ffEXVZCHhAgtbBGE8007E9mHQ8cwWQti6oLSBKd89yGZ8AO8kSxj
         lUgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782878478; x=1783483278;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=nbcaEzsRX9Wd5cutUSGHKNyzPWPZ9Pa/dME/ipm/wTw=;
        b=nM5kvNoSoNyUUwDbww0y0h8GZy1doU1KSP205RVhBhpKmIW9MENjVnU4dK0/MDqtYs
         MQtP+LkMu09GEv96Py4AZG6IRKou7UiaH9RooHk7HQpVbw8O/0NY3zTqeBNVB0xSJG7z
         bPuIOKtZVbDvhuOyOwWN4+IhHvUCrcO11DPqz5JMQ7vlly6a/7VMja/K6QpXwzlmZVca
         wRpuHDQVG0KeI/GdUZWnFWQJlAU/5tfFtcGDBcgN94Cr3HVkOvVaQ2tCW1WmizIYNaYx
         SRiETr81Jyet56aB21dyXGOjxgfsrIqLlR6tOGSaquiRCPLxrpypSlwzDnjGMuZMIzhO
         K5Gg==
X-Forwarded-Encrypted: i=1; AHgh+RrsqVGR1rDiNbU1dhp7zEiKqp+YtTqkYXVQYrUxOEVQkFeZtMi/hYKlS4ljfsAY1z+3UAP6mQ53SnBBqqpT@vger.kernel.org
X-Gm-Message-State: AOJu0YwDCJmrt6Y6rtGuGHosejHs4oX3n2MT6ZvJ0UewWIrKdBUw/fwh
	OPvmdkkLbImen9kDlnAtLAjV1eSbIREyo/UpC7u3ZrwDMcEVo+Q/XruTccAtsCuD2JvCthMEQUU
	yTDhyLNhLAyTb2qNMh2gF0yJl5k+6qTs=
X-Gm-Gg: AfdE7clzF4OgR4VeazQO6MC072H3YcgO6BBMK6VPNPkhI+W9XmQjO9gBpQaHK1aVUhm
	6jZeI4Ooj6NLhV/2UEdcA7GuxTPQNPiKxaR0GFrLhcHO0Vs4IY44yWECsSqW8vH+ACxkrxkt9td
	EKu97ZISxR7oZ9o+tOv4VolQuWbhpsD25gy/RzVeRNXz1SH5uRnojxTuEtM3vYBhFUW5hawH17n
	CmJrK89VAmqe/Yhq2qv/JGqxSIlop9+jIfmPnLzGJLaLS9xE4vEJ03ScE35W1Zfk6+SILAtD+9M
	1o9Ogdg=
X-Received: by 2002:a17:907:9694:b0:c0d:7c31:26a9 with SMTP id
 a640c23a62f3a-c12a79b53f2mr2792166b.2.1782878477949; Tue, 30 Jun 2026
 21:01:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <89ea76b3-e956-4232-8180-ee3929adf905@kernel.org>
 <20260625101132.3859505-1-safinaskar@gmail.com> <63f7860c-4f5c-4682-8914-27978b9fbfe1@kernel.org>
 <20260629-bauland-knabbern-abgeladen-c0acbfa62cc2@brauner>
In-Reply-To: <20260629-bauland-knabbern-abgeladen-c0acbfa62cc2@brauner>
From: Askar Safin <safinaskar@gmail.com>
Date: Wed, 1 Jul 2026 07:00:41 +0300
X-Gm-Features: AVVi8CdRVGURQNkveI8Kk-KHYrlO3h9NseHLMt2SfGvb89Oznrvksp3ZeC4J-SY
Message-ID: <CAPnZJGAJROqfCWSeeBu31HsE6nmgxVqHTNeC554S5y1Y-VN19w@mail.gmail.com>
Subject: Re: [PATCH v2 0/7] vmsplice: fix some problems in my previous
 vmsplice patchset
To: Christian Brauner <brauner@kernel.org>
Cc: "David Hildenbrand (Arm)" <david@kernel.org>, akpm@linux-foundation.org, avagin@gmail.com, 
	axboe@kernel.dk, collin.funk1@gmail.com, david.laight.linux@gmail.com, 
	dhowells@redhat.com, fuse-devel@lists.linux.dev, hch@infradead.org, 
	jack@suse.cz, joannelkoong@gmail.com, kernel@infinite-source.de, 
	linux-api@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, luto@amacapital.net, 
	metze@samba.org, miklos@szeredi.hu, netdev@vger.kernel.org, 
	patches@lists.linux.dev, pfalcato@suse.de, torvalds@linux-foundation.org, 
	val@packett.cool, viro@zeniv.linux.org.uk, w@1wt.eu, willy@infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 29, 2026 at 11:56=E2=80=AFAM Christian Brauner <brauner@kernel.=
org> wrote:
> The amount of regression reports that we got in short succession doesn't
> make it likely that we can merge a plain degradation.

Let me repeat: this v2 patchset fixes all regressions found so far,
except for major CRIU performance regression

--=20
Askar Safin
