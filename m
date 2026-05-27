Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B1493C0624
	for <linux-fsdevel@vger.kernel.org>; Wed, 27 May 2026 13:44:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779889498; cv=pass; b=OTVWXQtBLg7zZN7QIeaRhwUJikJVdtlpTyxIwsW/cn1mTLLunZAofPvdG1Y8SEe1j1vS72n36NNnCreaDK71eKO1hb50CxmHKBxZ6cKqg/lIPWQOhJq8+xQ1PciNAm6JIJJ+rPja4Y+BRpFcW8Vzj7z3FS01V93DtCp9JJ+JHZs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779889498; c=relaxed/simple;
	bh=it+wgDrDOUaTkC3IcpK4tnekNIzifQ1ajZKOntQ0lUU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WVrRmNuS5W3sGcwJDShi6dh9TlTW91MtXOkanaC97thMiy/edYpqQQo+WWRTVdW6NpSy95bShgYyzoNnNmkfcrkpzH2orAWQ3UQzPA0SZZsEhjwHGcYmyH0oHsEO18r+06YN42CMKlV4C6DJGaIKAfFCfHR9v9CxDsL2LvtZ1Mg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Ji+Kgosh; arc=pass smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Ji+Kgosh"
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-671588ab0cfso67a12.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 27 May 2026 06:44:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779889495; cv=none;
        d=google.com; s=arc-20240605;
        b=gl8RBii4Hvx/o17NmfTcLtd/HclZNnEixKtjzv8g/A1pHF42ALiVfIVbt/kZAinl4l
         oQ6ALBqNb0ujsqLdv7I3c8UNa602ZRkUsJOa2I7tFLihWyGkdW3goucNu358Jibph65P
         NHGtkfPuV7bdtWfBTvNF+RJkucDKMLUmCWYcLfopiGI7/FhN4Zdw8nD2TsJKD23KVerg
         I/JXBrQvD1BzhTsQZn8yhF8f6RJZMeHvduQ+qTj3cQdKIi7NTLlw7/S0t9SyolWhFI3O
         Q5ZT+g1g1Hd0slfnuw7RFX29LWk7gMwoDId/JbDbJKWXYg0TParPpehBplWO4tEQeIgm
         1j9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=it+wgDrDOUaTkC3IcpK4tnekNIzifQ1ajZKOntQ0lUU=;
        fh=Ahtj82CCzfrglys9Cjuxclx7o62/BlxzEnExabVigQs=;
        b=J63HFcNqQkchwgr/qsI4Ft8t+7PxWmGQ5xDIB3Exc1e7HfKjnDFFWiNfzV8zaCedRW
         G/4tFed2k9mFnsZVuCWjgM4ixPhQKWzHftMesTT3YdK0eXcFf8Sf20DVzTjNLqp8DBnZ
         WduWiWJuLt9yreIfo7gba7G8QCjJcgbF8U7/ygTkgoNCKPpP/VCapXJIM4gwQci2rZiB
         sp4Ml5OVHSKwOOE9PQeIktgTzZMEUVfeFUm+XzLTActsig0YWl77VJYBciRDuio/Wzuf
         J6hdHdYGkUkHQ9AJ4myV9NbQ5IHHdImXNm5oG+CcMuu4SwNEjVXiOfaaYXnELHUxvYAM
         jfyw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779889495; x=1780494295; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=it+wgDrDOUaTkC3IcpK4tnekNIzifQ1ajZKOntQ0lUU=;
        b=Ji+KgoshnUgwZ6ZlzEJhuwi26Z4oR6h3CQO9rOpKb+bTQFbNXyV3pBHrrl9bnkgzsW
         Rn7nyEC+EBrSatgEDC2Yi6BZV24R82kBK4wqX0z4elhr7zJTDuYOfqotNoC0KRoYaWVA
         HR/CwWBYxz2UASgAV9Pwl51NjP+xbqlRDV3GK4p7a44aN2zNGZqMtXgzYTzm7JXki5jH
         0NTAc2RIB+dnITKZZA4lrpU2dFR3+xvlWggSiX5j/39uuygoGEeo+5rqv5k87Pq9qiyl
         4QH5YmPDzGA18uUAnFvf092xKrcZdgAFO99ZW11Jlbz99LdOJGewH0oJwakmKDo8PAZ+
         jP8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779889495; x=1780494295;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=it+wgDrDOUaTkC3IcpK4tnekNIzifQ1ajZKOntQ0lUU=;
        b=RZKa9PYSmQ6NmJSTP/IzNNg+gsnTbP+qW27A4owXYWpBeAGiGTJfb06SPtM7pk639d
         rSVC9vA3Qnur0VrK4OKBXLBQ+7/Tu3JNJ9YVgOdUXVF0UE6lGEom0kOolCQyuHLs4xWG
         bZtfz85F4IKm0k/7L2IoeZaN5x5hg6FllpxMkfJB7gaG7MVive3QRAY5hYjNRBHftaEA
         iREawWA7BZRu1m+QKoNCtsXMf3Q0CbnFqnI8TypKSiSoq28R4EBCnB1G078uzMttLZdt
         u+dzOL+wjFMrUuHvEIKU0ycbR8/0qRVHtW2xJxiIJGByxmgM6E9XnDGuSYvgn+2+r2Fk
         Va6A==
X-Forwarded-Encrypted: i=1; AFNElJ/YhW9ZhiU0s8HQepYl4ciwk7gTkZfMj3sEjqobnh/RSIq0QeX7kydQiTzp/a5ZrVZgu6yUZd0/hVkZGMhE@vger.kernel.org
X-Gm-Message-State: AOJu0Yyfl+eUfyP0vZCOXsvLftkd8RI0uGjoMijGAjRyRjOb3XaBLQnw
	5Ogaba05FXWMnuz6F5WVXLvHf9Wu2Lvn6c/Di9LsP0nJ2cU4c/dG+lhbGE4Gh8nfGXDIaYcFPV9
	YI8/5JE+Xi0Axsggsjapw5vDrIUYM9K58dLN+on0IGr/RRR0/ovIAH136nM0=
X-Gm-Gg: Acq92OELsgHyj+mbpWjfd50eYfQb0xOcIC8Ku/FQpquiIktDSS76y8vz3R53wAEYeyx
	vXBjjYyfT19+lqpNPaQrFJG7rhJQ+kpE7IC9eM9MzF6OR0O3ubZDQWOqz0ycDN4J9zlGa8ThrSD
	djL+oLJBn5zgq2t2tyE/adpXIPOSOsfaCDVJN6fhV1bQBopJdYLTEuteMAt9FnXcLMWjis3/buN
	Mk7CWvs97N2JRkgaJtPdUhOOqaltWUVMSeuNv+oLVNuAw8vfcVmctO31qJ3WHxCQBGp5LTZ3gfS
	Yq87bNItSrJyKxrRPdFyUaqxxZdVkdfY2IBC/UTE0XVVyYc=
X-Received: by 2002:aa7:ccc2:0:b0:688:9c23:24aa with SMTP id
 4fb4d7f45d1cf-688fd170966mr201286a12.10.1779889494816; Wed, 27 May 2026
 06:44:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260518-procfs-lockfix-part1-v1-0-5c3d20e0ac33@google.com>
 <87ik8b2rh8.fsf@email.froward.int.ebiederm.org> <CAG48ez2pmuoTCZh_AVKDDLeQEYmm=gLMgThnqFhRMFfZvABpdw@mail.gmail.com>
 <20260527-kuchen-fassbar-hauer-4b6fc31e3395@brauner>
In-Reply-To: <20260527-kuchen-fassbar-hauer-4b6fc31e3395@brauner>
From: Jann Horn <jannh@google.com>
Date: Wed, 27 May 2026 15:44:17 +0200
X-Gm-Features: AVHnY4IwVOUJ6HpRAEw8Ai0JNxQIpmPDN57CZnT6PMEZZ7u42kilPF7NCJg2FkA
Message-ID: <CAG48ez1OfP4umNSeGzw4YhZi3dcb1jsy-vrKUwMc9+SLpt3isA@mail.gmail.com>
Subject: Re: [PATCH 0/2] proc: protect ptrace_may_access() with exec_update_lock
To: Christian Brauner <brauner@kernel.org>
Cc: "Eric W. Biederman" <ebiederm@xmission.com>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Jan Kara <jack@suse.cz>, Arjan van de Ven <arjan@linux.intel.com>, Jake Edge <jake@lwn.net>, 
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	stable@vger.kernel.org, Kees Cook <keescook@chromium.org>, 
	Oleg Nesterov <oleg@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 27, 2026 at 2:01=E2=80=AFPM Christian Brauner <brauner@kernel.o=
rg> wrote:
> On Tue, May 26, 2026 at 08:22:38PM +0200, Jann Horn wrote:
> > On Mon, May 25, 2026 at 9:56=E2=80=AFPM Eric W. Biederman <ebiederm@xmi=
ssion.com> wrote:
> > > Question 4.
> > > Is it possible to use a seq_lock instead of reader writer semaphore?
> > > Or is that only for non-sleeping readers?
> >
> > Linux seqcounts are 32-bit, which means they are always kind of dodgy,
> > but they are particularly dodgy if a reader can be forced to sleep for
> > an extended amount of time. I don't see a reason why we couldn't, in
> > general, use a 64-bit sequence count for readers that may need to
> > sleep while reading.
>
> I have a patch series for this that I started working after merging your
> series for precisely this reason: performance. It's a few days old now.
> I've tried various approaches and I started with a simple 32-bit counter
> as the POC. See appended (untested) patches.

It looks like there is a missing patch at the start of the series,
patch 1 uses exec_update_seq_begin without defining it.

I think performance improvements from seqcount use like this
(accelerating the fastpath) are different from what Eric was worried
about?
