Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 446111ADFE4
	for <linux-fsdevel@vger.kernel.org>; Thu,  4 Jun 2026 00:01:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780531295; cv=none; b=lm9dkRR+JHqhwwjvRkztnZe9KIxoZLLwI54/Y4Lvv8+J/PRtYufZRM2cg11LwPZJ4cls3+0p7fcv6csA0c0Fhi1fjClhWedUtfqJftVW9LKhdBb1KA5WgP9cQW0ICQMwp4UwX1APJlJHt4Q8MLIpo7AI2Sh10EOtbzRL+3LpDoo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780531295; c=relaxed/simple;
	bh=uQcJ3DbEdxsfH/k24j2l4FHVQEAFZdw9HA2H2VMaFx4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aj9niFnsBQj5N/6yCySj4qcz9pF3gr8MjsKRiH2OugjrlF4Jw9dotVKTC6nqjPAqHArr7djtWsfhTqcHXcxFZqDzdOEQfQYDG2rM0n8zixtOAuBww9ikDPELRQn4SK7QSElhDPBm6zjaEPdLdkCjOFPpLiG+ILaKFIozfKDOuCE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=Q+p3H2Z7; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="Q+p3H2Z7"
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-c8584e80d59so39654a12.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 03 Jun 2026 17:01:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1780531293; x=1781136093; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=fmwtcO9oMtO4r20fiMVX6YvjF6Gi+HYM7qIN8rIiuJU=;
        b=Q+p3H2Z7ql3lAznVf4UaH2BG0/fD3s6GNPt8duObqYDXjaceJa7Qy3kJ8WXIYZIwsD
         wa3CNvfZ1Gn2/rVoOIN/7+AbCsEx6pIQ05AqDSzE4klHViu9OWbG1TWDElD1tpgUxrfH
         66dwMMPXazSLi57iXYm+aa/lc1pIArh9Gt4Fc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780531293; x=1781136093;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fmwtcO9oMtO4r20fiMVX6YvjF6Gi+HYM7qIN8rIiuJU=;
        b=MS+diOsTgGetnoinq2GDdWRz7vcQP+P7uKLRJR60UzxKMUm4cXDWDxJzuWe9eWmKQH
         +t+OllH4Qf3q/WQpnu8ZXT84Bq3O0e5do3aGb/tyECO1ZmaGkXjoCoupJSPUcVSIKfBx
         y3Ejpe/OAnNQ6wX56RslwHuL2uTRi/smmpEncqdAyjCQGVcc5zzgwMV/xqb82yifSJXG
         rBsGg8TGODn2slxodB73l4Eamrat3oDtEuVTFm75SZ8XPYpqprMGAM+MPM368h/5OVzr
         P+ewrBj0m2QFIU2714yEwlFsZOoJmSJkrIMJ4L3eeU4B5FnXlhq5R65O+RVc0GrXTTCJ
         FFiQ==
X-Forwarded-Encrypted: i=1; AFNElJ/p9vgM8GhgVAQYgWxRox/mKwWALB3T/VBqqbRBnW3zxqK26zeOPWXwg70JOX6/ZAytot2H18Hm5IIopOAf@vger.kernel.org
X-Gm-Message-State: AOJu0YyYM02AxvafX+7dm0wkPmQLJigbeH19oRSAmkAPvwdycjoVSH+l
	eBfogQUYmmEJbwYs5YkXxMVI0SND74ksAtpXJ8G1BR0c4AKyqohfWJtLGDpZ9Z6o4LyH2Jkqkpc
	Ow21wFNkBEw==
X-Gm-Gg: Acq92OGPZxE9L3sFEx6BIvBCCAHinKrGxpE0hgzCNoNL4EzYN8wmreFVue+ihE5qf3G
	bwSSDO7mFK52Vdzb+iUAdQobP6A2PHYjAK77kfp2ZKRNEXqe2nIojDnhwwmSdomqVATPv3awTpc
	MSvMh/mGtcsS4rQGxqe8UNanAKp1czIXL8NqFbS895ZJmXNnJjxGk+dHoIo4BfKA6pE9JwqVhRe
	+PaH34b6Jqo/Vkm6sGUEN/GShdDfZd+/FMEufb/DOrSuBqjL17a1jjMXACwnWJLy3GtEYHgg5by
	yGNI6AaRNHToUWsxdjRDbHll5VA4rvdpVjqbNv1gjvyb48HiIL1vlHqNWbIBA4XEZDhHfwcmFFJ
	dEJB1cFZo1eWGNS27U2UMGu86Eo843qoGRkrKFOvwlSgvb0hlafuFsjTHFrMVgj1nVTOyQpVM4l
	0CIKSE4HQvLQZrAH2QSWsjNzV1BegEbiMfOE1vcbiGC5NLshbEnpgAdun5aSM9+Nle3K8N4Jz1/
	BDQuPLzHyQ=
X-Received: by 2002:a05:6a20:d80d:b0:39b:ba95:b14c with SMTP id adf61e73a8af0-3b4975dda17mr6226180637.24.1780531293433;
        Wed, 03 Jun 2026 17:01:33 -0700 (PDT)
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com. [209.85.216.46])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c85df0a4afdsm3948231a12.19.2026.06.03.17.01.31
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 Jun 2026 17:01:31 -0700 (PDT)
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-36baeec21dcso37267a91.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 03 Jun 2026 17:01:31 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ+3W0vCjbkJdCPIXQzFDKPz3l4DAVbv1fyyux52qKpsEXYG7ZsCczFquNR6GAiR3UvyMvGuX+UybMlsrLK1@vger.kernel.org
X-Received: by 2002:a17:90b:2811:b0:36d:5dbe:2a0d with SMTP id
 98e67ed59e1d1-36e30c23af4mr5607319a91.7.1780531290626; Wed, 03 Jun 2026
 17:01:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CALCETrU94ja56CA5CRtXrm1v_7gBaPUNOHKQzS=JNF9JZ7Fznw@mail.gmail.com>
 <20260603230122.851517-1-safinaskar@gmail.com>
In-Reply-To: <20260603230122.851517-1-safinaskar@gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 3 Jun 2026 17:01:11 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjARJSHGWvZKJysvZOVEVi7bNL5x9K2X7ifhfLA9YK2sQ@mail.gmail.com>
X-Gm-Features: AVHnY4J3E2GAiTMiUKCy1DVjF0CiXaoh4gFXUo3phzZ8FQ9ufT44d-VKtd1uRR8
Message-ID: <CAHk-=wjARJSHGWvZKJysvZOVEVi7bNL5x9K2X7ifhfLA9YK2sQ@mail.gmail.com>
Subject: Re: [PATCH 0/3] vmsplice: make vmsplice a trivial wrapper for preadv2/pwritev2
To: Askar Safin <safinaskar@gmail.com>
Cc: luto@amacapital.net, akpm@linux-foundation.org, axboe@kernel.dk, 
	brauner@kernel.org, david@kernel.org, dhowells@redhat.com, hch@infradead.org, 
	jack@suse.cz, linux-api@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, miklos@szeredi.hu, 
	netdev@vger.kernel.org, patches@lists.linux.dev, pfalcato@suse.de, 
	viro@zeniv.linux.org.uk, willy@infradead.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 3 Jun 2026 at 16:01, Askar Safin <safinaskar@gmail.com> wrote:
>
> So, if we remove tee(2), then we will probably need to remove all
> non-standard implementations of pipe_buf_operations.

I don't think tee matters.

Sure, it will share pages across pipes.

But if we make normal "splice to pipe" always copy from the page
cache, nobody cares.

You can corrupt the resulting pages as much as you want - through
multiple pipes if you use tee() to copy it - and it's all just
corrupting your private copy.

And yes, iSCSI and nvme might do their own splice-like thing, but
again, nobody really cares. When it's all kernel-internal, the attack
surface has gone away.

So that's why splice() (and vmsplice()) is special - not because it's
buggy, but because it's the user-facing attack surface to expose bugs
elsewhere.

             Linus
