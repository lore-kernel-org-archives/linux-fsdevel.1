Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 318B64F68B1
	for <linux-fsdevel@vger.kernel.org>; Tue, 13 Oct 2026 20:29:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791923344; cv=none; b=tSSYWY50s5YD55uvBXGUeDq1YdH1a1Kn/e12jcIj30Gey+gDX+eLoX1q/fdmbtrjSBOumlayyN3OlSpyBmAyKdP8xw0exlWMSof+eAiU2MGVhp8WfCiv1Fgsds/ReE6qHBEkbErv8tIP/6EsCult2QAAijAY5vKnjw6nau36vUo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791923344; c=relaxed/simple;
	bh=6WLrdQptrJArGJMGv3NltYtuEpee2CJJc5BKqgZAghM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Z9ohWaOxrsIahJLCjtS4H8FdaQH3BhyGlHEehLSLQdPASXTA9PriJzRKfJqqBUcr70UfqY5kXSh7r1edGQklpqxLLU7Gc29MfKpCrQ3XfEk1e0iPkt0U1eXbvwQz1tErK3HUMZ8Y2dhtuGBBOW0fskRDnWWxTaV1W31EbIhph1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=pass smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda.com header.i=@toxicpanda.com header.b=cmRYMx/f; arc=none smtp.client-ip=209.85.222.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda.com header.i=@toxicpanda.com header.b="cmRYMx/f"
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-93e441e14a1so244186185a.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 13 Oct 2026 13:29:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda.com; s=google; t=1791923342; x=1792528142; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:content-type:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=dohylkge6OeGVizhzGCANBuwwSEz+KJDIqf/mQitXs8=;
        b=cmRYMx/fpjMfMXv6/wVBv5oJhiN9q86aQTYmBqJNN2bqq9f8vRJ6Me6D1TNxiDuGV2
         uLugf+im0ZLsNj+QbBXArtP+LzFQWF4jZ2LGPKQ7SLnoPe6h3WiDfCNEKIopiAGgIZhq
         HXPtp3e5T6cFlPk9TL+L20YnSwzOPiTI6GVPn1AWROOEIsP90oR9sQUn1gEFaRQvHJ+Y
         88EikCqPg54See2CAppPtIAHRQJ9bGaFRBlxrcN3IXfrZVxuZUm/McyRPWOKB8cUebOf
         ZeJqdH5iryIlamTZTkpqvpvSckOfqeOkghpROSKiKipi1hn+/jk0a6v5HVf1aOKM8cLU
         lTyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791923342; x=1792528142;
        h=mime-version:content-transfer-encoding:content-type:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=dohylkge6OeGVizhzGCANBuwwSEz+KJDIqf/mQitXs8=;
        b=EAMRe6p4WwHT9ZA7WICdmBJy9omEjCuZovuSw3WS4RwGPpgHnkvHmvJ79iWqfc5kzb
         XRu1IWf8SqryJLLyVBgP7ZKew4NfMmOr0vMh1jkWPvgGBdbcR+fqu8Rsh/wQkF+P5qw4
         I2OwNGBuOaOyZFt7rvdokHdu78E2ALpzp7goiUGlw79eai0dbVPcIr5bt2PYwHXA63Kh
         gu9/Cg9GL6yKBNa60E1qa7tjZvrBqvg+qq8CWdAfMu4aCa5gnZhA617cxvqicdPeqCcu
         ZMm4VjsLxqw1mf6RCLQns6X3tcGXDprLpRKgZjkbbgajF8Kta6MHgxjjNz6yR6qlcuGk
         R4Tw==
X-Forwarded-Encrypted: i=1; AKwUvBxgyQ3UuRuh+V8jvpB2QXnRFNBoSd8LfJgC88wuMY/QFZaAQ4AZbfKuK3VWuOgM6xN9YBkXIscSZlgFnXdy@vger.kernel.org
X-Gm-Message-State: AFq9FYLuNqx8LlRGP2UDxcVc45z7zt68xHx9q6m79KH50NTmNt+Yezeg
	MiFwY32dDM0u/zyMZDMYjHYEnW0/L45/Lg9IPAtc/4ptQ5J+HgrMoNTVtHuCX7j5tuY=
X-Gm-Gg: AYBFou2LQ+KlJTrMpXGo2OKsUg6Z5SMVg0h4TTmUeD/bwR7VKsUJ9w7SL/Nb/zORSuK
	rksinM4xSB6lsw779ywYJx4tu3PhWEa9tk4jeGdPylIfrYKV9rttzj/8aavV9Yhq15O1cPIFerP
	qCBnTe5scnCK9B//CcitLKHlkuxFp9hQvNtGnPH7j4/k0Z4R57ZbkRA+NDNY8GgPGHAxFWacyTC
	WqFr9pW2lWo1EkLlqCQJmACyfkWKZVxo1dB7bUsNku8PZF9j4CM2F4oqIq5sf2kYBookavm+dOk
	9hedPKemFh54flhLbC8SXG90lT67eKooh6a+hEWjgivX5sNduQAT01NLuIWiMbzOu98uvOsgeXZ
	l8Zm/tXrpv+Z80oRM3Am5cr/S2b5RyonsJtgN6vXC1ZCsSGhcrJMlg/tfw3QCcEwHIYQFmIIP19
	1ftrdEv9TQhE1z3uAX0C0DJzPb6T27cftYLfDxn3U+Xa2QQbzcTNwvwamEz0AnE7gxNfM4mtgOE
	Rpkam3+urL1cxU=
X-Received: by 2002:a05:620a:2591:b0:93b:d7a3:45d4 with SMTP id af79cd13be357-93ebd29c0bcmr2207495885a.61.1791923341761;
        Tue, 13 Oct 2026 13:29:01 -0700 (PDT)
Received: from toxicpanda.com ([153.61.196.253])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-93ef5028051sm321623085a.18.2026.10.13.13.29.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Oct 2026 13:29:00 -0700 (PDT)
From: Josef Bacik <josef@toxicpanda.com>
To: Christian Brauner <brauner@kernel.org>
Cc: "Serge E. Hallyn" <serge@hallyn.com>, Paul Moore <paul@paul-moore.com>,
 James Morris <jmorris@namei.org>, David Howells <dhowells@redhat.com>,
 Jarkko Sakkinen <jarkko@kernel.org>, "Andrew G. Morgan" <morgan@kernel.org>,
 Serge Hallyn <sergeh@kernel.org>, linux-security-module@vger.kernel.org,
 linux-kernel@vger.kernel.org, keyrings@vger.kernel.org,
 linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 0/5] capabilities: close the ways around the CAP_SETFCAP
 rule for uid 0
Date: Tue, 13 Oct 2026 19:32:13 +0000
Message-ID: <179191993398.6.7035194670175996999@toxicpanda.com>
In-Reply-To: <20261009-aussicht-wortbruch-bohnenkraut-9e7a1cfd7580@brauner>
References: <20261006-b4-setfcap-userns-v1-0-f47e7ed66072@toxicpanda.com>
 <asehZEWAwsJcbqvM@hallyn.com>
 <179147397027.4.15064782992163283819@toxicpanda.com>
 <asfBRYy597qvzdCW@hallyn.com>
 <20261009-aussicht-wortbruch-bohnenkraut-9e7a1cfd7580@brauner>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, Oct 09, 2026 at 09:41:59AM +0200, Christian Brauner wrote:
> On Thu, Oct 08, 2026 at 11:13:57AM -0500, Serge Hallyn wrote:
> > Yeah, that's what I was thinking.  Or even stricter: ensure that to join
> > any user namespace, a process must have a superset of the namespace
> > creator's capabilities.
>
> I think both are fine and I like this proposal.

One correction to what I wrote: the weaker version isn't enough.  A
namespace that maps "0 100000 1000" doesn't map the parent's uid 0, so
it passes that check.  But with an idmapped mount that maps fs 0 to
100000, a task that joined it can write fscaps that are stored with
rootid 0 and honoured by the host.  We test that flow.  So it has to be
Serge's stricter version.

> I think that this is an acceptable restriction. Mapping uid 0 to 0 and
> dropping caps is borderline useless.

That makes the restriction wider than the 0 to 0 case.  A root task
without CAP_SETFCAP couldn't join an ordinary "0 100000" container
either.

setns() also only covers the routes that go through it.  These don't,
and need their own checks either way:

- writing through a uid_map fd opened by a task with CAP_SETFCAP
- ptrace and pidfd_getfd of an entitled task from outside
- a task without CAP_SETFCAP creating its own namespace, which a
  privileged task then maps "0 0 1" for

So v2 would be a level on the namespace computed at create time, the
strict setns() check, and the checks at the map write, setxattr and
ptrace reading the namespace's level instead of the cred's.  If that
sounds right I'll put it together.

Thanks,
Josef
