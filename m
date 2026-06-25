Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D00BB386C1B
	for <linux-fsdevel@vger.kernel.org>; Thu, 25 Jun 2026 08:54:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782377651; cv=none; b=fHvd/QBPIR0wU0FbSUbhlZ3Z9m7crz3RTIVIQUW0K2TSO2Q68DRNPk2zQwEtcQDcOKRfVMYc3RFIgeKm0HTHirFmLT8qHh9la1T1DRzdXC/uyt3o5E31KPlympds8HSlkEdnqCkWmi9FkFc+PHbBmoWrFio9mH2TpawZDFhaSWk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782377651; c=relaxed/simple;
	bh=07Gz4DVxSchKBz41aocKqPwLf5Q7wYxmqWLTrZ9H6nY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=U1y9TtBAICVvjHcaMOS9GPkuHi8r2kgpZ16Vure9cWj9jAsDxMqqk7N/s0vk84JOA0NdgHrpyEsizRG7Xr0qCVkKo3+1O5GvHOUqHOyGPGECcXeqvfyXfnJds0hhbOrYLCyjDXCa8NtB7LbcSTceu17UPEfyut88izhaQ9t5OIM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TeZSIzER; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TeZSIzER"
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-46e30429b10so64267f8f.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 25 Jun 2026 01:54:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782377648; x=1782982448; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/jDoMmJJU0PpNgF+w3Xx9Gr+Xmtdk7u64RSrEr55CTg=;
        b=TeZSIzEROk+wXDUJ2H7J9qtITFj/majCzC4RRZwR633P94dRl4K2X4xiaAK7By7ze+
         K7DEGTJXoevUXfACUrh94xn6QJW/a9k6IusZA+lUxNCYXYF8S42eYkontmM4rq0Na2aQ
         VAdzE3UF3hq9AN3CidWOXPvSKb8xj/JDx7dUSbkR9TK0a4z59WyHTnjeoB6VqCsbWJCd
         waHDjV9/lCOJFuenJhABaW6KNlKJAQTtgSEFSccoL/kpVwQ5UPfl1w/boO/W8vAonLkh
         N+SyAwoJJ5z6KfqBhkwIIquIKvHtokZto2zPXoQgTZiVHXJCs0z+izxUUJ24lECJRKpq
         ljPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782377648; x=1782982448;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=/jDoMmJJU0PpNgF+w3Xx9Gr+Xmtdk7u64RSrEr55CTg=;
        b=C/frpj+oHb9jk6p7ipQu85PQB3cnnCu5bk/d3Uh99WRFrvJTPi93Or7ZPL6aJaDKg6
         2rSQJFV4qrl0SYumJdC5bLciHEcFwfzwYRwRzzErq/TbIRs36lbbO3nn98RNcIkyL5BF
         Scz0akocgq9UuxZlwTInHb+E/AZ9NvbK48KfDnB+0DD3tqR77575kULqGPScDkWG9iHp
         sKpJ4yo5E2xVOoQvXE6GKNA4FxevRT9ji3fGp3ig0W7wl+OBE4K3hd0xnUXKE2AYu9zq
         3aYiTEAI+NT9tk0kC+MNNF7wO/9rQXqeilreMdhmMc28LDhFKSWyU/qFV0EfpkQa5qx3
         +YHw==
X-Forwarded-Encrypted: i=1; AHgh+Rp8efa9h2jJUlhvhx/J39z6FxD9z9ULebUBcEvXVdOYjeApqso0qg3eCJ/hD1fPglnBgJusAM/iuvEbIHoF@vger.kernel.org
X-Gm-Message-State: AOJu0YzdirEWo1CgQAWCLIP4mVxtQSAGJ33akWjZzyYjasizI3xSENI0
	e3JGoxPWgI+1eMe+7ArZypccR9+7FYV7Qvvv2FbFLCc898Ne3vI8HoGQ
X-Gm-Gg: AfdE7cnbT+L/9zazcmq7SgQ4VG9dzfo4BMdEsk/A9Q+pwmxRbr2/k8A8xTN96yYrpC8
	l8xHFG4e/4ZBEenfhbD7+Ez+kC7qrHv/mEGEjlP/8uRIYNuYs7ITyGYTW464Etv6OrL/Gm8/qRS
	vcliB36EKxyZDkzckTynja1mFqbO0oXDhPbL0P7s5YxcVGOvDQ8DWjkvyERKcOf98+GTwoyGZOd
	z9MoATZkk4Y7XgX9Lios4lY2IxRQ9WEIh2ms/mT9rlt/bN+9lQpdMSURamn2VYj3bCSEv4jYz5+
	wXUKgEx2dRhCffx6erTuje7vFM66nDtRdqtzni9IpZdrEVscAfa+X2bjkiUUqFpU9D/qWe5sJCD
	2/LLB06BCZ3vjCJf3EQ6a5XnA9Q8MFNWxZ+NN0Cz86vCqOoWma+Hc1YvbvD5BJLh5cCLf+JRaU/
	4SU/zCzk2b
X-Received: by 2002:a5d:64e4:0:b0:460:67b7:54f1 with SMTP id ffacd0b85a97d-46dc30e2c21mr2268492f8f.42.1782377648254;
        Thu, 25 Jun 2026 01:54:08 -0700 (PDT)
Received: from localhost ([212.73.77.104])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-46c1ee018e8sm15530598f8f.11.2026.06.25.01.54.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 Jun 2026 01:54:07 -0700 (PDT)
From: Askar Safin <safinaskar@gmail.com>
To: avagin@gmail.com
Cc: akpm@linux-foundation.org,
	alexander@mihalicyn.com,
	axboe@kernel.dk,
	bernd@bsbernd.com,
	brauner@kernel.org,
	criu@lists.linux.dev,
	david@kernel.org,
	dhowells@redhat.com,
	fuse-devel@lists.linux.dev,
	hch@infradead.org,
	jack@suse.cz,
	joannelkoong@gmail.com,
	linux-api@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	miklos@szeredi.hu,
	netdev@vger.kernel.org,
	patches@lists.linux.dev,
	pfalcato@suse.de,
	rostedt@goodmis.org,
	safinaskar@gmail.com,
	torvalds@linux-foundation.org,
	val@packett.cool,
	viro@zeniv.linux.org.uk,
	willy@infradead.org
Subject: Re: [PATCH 0/3] vmsplice: make vmsplice a trivial wrapper for preadv2/pwritev2
Date: Thu, 25 Jun 2026 11:53:57 +0300
Message-ID: <20260625085401.3787887-1-safinaskar@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <CANaxB-xUrLQYGiRJZc4Boi+KX=0TJSWymErNovANVko20fMDVA@mail.gmail.com>
References: <CANaxB-xUrLQYGiRJZc4Boi+KX=0TJSWymErNovANVko20fMDVA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Andrei Vagin <avagin@gmail.com>:
> On Wed, Jun 24, 2026 at 12:12 AM Askar Safin <safinaskar@gmail.com> wrote:
> > Does CRIU actually rely on ability to do SPLICE_F_NONBLOCK vmsplice into
> > named fifos? Or this is merely a test?
> 
> Yes, it does.

I. e. CRIU relies on that named fifo behavior? Okay, I just sent
v2 version of my fixes. The patchset contains fix for named fifos.

Please, test that this fixes that named fifo problem.

> I already explained that this isn't just a perfomance degradation, it
> actually breaks the pre-dump mechanism in CRIU. vmsplice is invoked from
> our parasite code within the context of a user process, where execution
> speed is critical. A heavy performance penalty completely invalidates
> the pre-dump logic, making the feature useless.

This is very unfortunate. But I still want to remove vmsplice.

> At a minimum, we may need to consider a deprecation plan where vmsplice
> with SPLICE_F_GIFT triggers a warning for a few releases before these
> changes are applied. Alternatively, we could introduce the proposed
> behavior alongside a sysctl to fall back to the old behavior and explicitly
> state that this fallback path will be completely deprecated in a future kernel
> version.

My patches change not only SPLICE_F_GIFT behavior, but also vmsplice
behavior in general.

Let other developers decide what to do (i. e. do nothing, remove
vmsplice now or implement some deprecation scheme).

-- 
Askar Safin
