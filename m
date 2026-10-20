Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=84.16.66.169
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792489030;
	b=FmhVLLX0e6zLvlOH1q34cFpG93HSJhhKXaaGJbz4sgagVGKtyyq3A9TSACyKxwMFGwtX
	 oqqVlEyGHIJ6AbcdI/+vIu7nG5a1coaQYOKmQC+ronDq85ojj3vHbdEqe01t6cz1QekT3
	 fpmZRtbXqGf2rltsQymgSxcNQfBOHYlfpNkyn1VxrgxwO/V9V6qFw86O1hTAfbuHZ8hBY
	 zAt7c3WxA70j5TfSNgmeFfjwyn2f6RSEBMypW3okt1LNAvd5YnFS7WF8p6eMOrWmI0LHW
	 6I6mJEObl17/EHPRMC/MyvQ+Oy/S2xn5J/tsiRPzv2+CSOtY1WCcp65pfYlJwYgGZKw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792489030;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:Content-Transfer-Encoding:In-Reply-To:
	 X-Infomaniak-Routing;
	bh=pKWxhEQSNvo/BWqNTUN+8vLhgAbAXI23tyxrRKdGIUw=;
	b=w+dJtuKrBMdaM+nDQ0U5QCTuJD+nK1Hc/C+Dd8+msyObpezeV9DNpnC5lmXVG1CWFcE/
	 vRsrbwlV5PspDOWKDftPR2h5DYq2aQWJ8/EOuahQo/7bq7X8aeLqBtJvjsxLb4xquVrwg
	 2cuuEDlFy+rZ5pMNxRe9p4Lo9fhOWeAbU1EjGyyPq37C49tjfsAxZeJovFxfoTQL/S1lz
	 Vju8++rthpK+C+8cssGdJ+jYhKhPbbDxC9xE7ac+LwRtbyA00deu+PoZZR6xsRsqxe/rO
	 Aa3Yim9RX1bGGqXNkzKEAg7TCZBRYblkXHEDkMtPMEZXcJxX6PP32P3Uqz3lh2mn3WA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=digikod.net;
	spf=pass smtp.mailfrom=digikod.net;
	dkim=pass header.d=digikod.net header.i=@digikod.net header.a=rsa-sha256 header.s=20191114 header.b="Trx2GwB/";
	arc=none smtp.remote-ip=84.16.66.169
Received: from smtp-42a9.mail.infomaniak.ch (smtp-42a9.mail.infomaniak.ch [84.16.66.169])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95D37606A33C
	for <linux-fsdevel@vger.kernel.org>; Tue, 20 Oct 2026 09:37:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 95D37606A33C
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=digikod.net header.i=@digikod.net header.a=rsa-sha256 header.s=20191114 header.b=Trx2GwB/
Received: from smtp-4-0001.mail.infomaniak.ch (smtp-4-0001.mail.infomaniak.ch [10.7.10.108])
	by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4j86kk1Ylxz29ZS;
	Tue, 20 Oct 2026 11:37:02 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1792489021;
	bh=pKWxhEQSNvo/BWqNTUN+8vLhgAbAXI23tyxrRKdGIUw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Trx2GwB/tjncatznurxpfHn7+RlCBrnTpeGnp7JWMqXSkUa97AHE6DRefRfbGSpHT
	 hLPcgXxJKoh7wmgmP47MHupee04AUbIx9lKPg9cjut5YyT5uf4mAERRyV9P3ZjGgHu
	 fo634gQKlAv0oEpuwhulmv3sr+HjgyzeMnNG1TJ0=
Received: from unknown by smtp-4-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4j86kh5Zppz2Zs;
	Tue, 20 Oct 2026 11:37:00 +0200 (CEST)
Date: Tue, 20 Oct 2026 11:36:59 +0200
From: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
To: =?utf-8?Q?G=C3=BCnther?= Noack <gnoack3000@gmail.com>
Cc: Christian Brauner <brauner@kernel.org>, 
	=?utf-8?Q?G=C3=BCnther?= Noack <gnoack@google.com>, Paul Moore <paul@paul-moore.com>, 
	"Serge E . Hallyn" <serge@hallyn.com>, Daniel Durning <danieldurning.work@gmail.com>, 
	Jonathan Corbet <corbet@lwn.net>, Justin Suess <utilityemal77@gmail.com>, 
	Lennart Poettering <lennart@poettering.net>, Mikhail Ivanov <ivanov.mikhail1@huawei-partners.com>, 
	Nicolas Bouchinet <nicolas.bouchinet@oss.cyber.gouv.fr>, Shervin Oloumi <enlightened@google.com>, 
	Tingmao Wang <m@maowtm.org>, kernel-team@cloudflare.com, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org
Subject: Re: [PATCH v6 6/8] selftests/landlock: Add capability restriction
 tests
Message-ID: <20261020.eiT3bah4uy4a@digikod.net>
References: <20261014082718.1435842-1-mic@digikod.net>
 <20261014082718.1435842-7-mic@digikod.net>
 <20261017.63923e5027e9@gnoack.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20261017.63923e5027e9@gnoack.org>
X-Infomaniak-Routing: alpha

On Sat, Oct 17, 2026 at 12:20:12PM +0200, Günther Noack wrote:
> On Wed, Oct 14, 2026 at 10:27:12AM +0200, Mickaël Salaün wrote:
> > Add tests to exercise LANDLOCK_PERMISSION_CAPABILITY_USE enforcement.  A
> > sandboxed process is denied a handled capability when no rule grants it,
> > and an explicit rule restores it.  Unknown capability values above
> > CAP_LAST_CAP are accepted at rule-add time yet have no runtime effect,
> > because deny-by-default still applies once the domain is enforced.
> > Stacking tests cover the per-layer allow/deny combinations, including a
> > layer that does not handle the permission, and invalid rule attributes
> > return the expected errors.
> > 
> > Three tests exercise non-standard capability contexts: enforcing a
> > domain via CAP_SYS_ADMIN authorization without no_new_privs, restricting
> > capabilities gained through the kernel's user namespace ownership bypass
> > (cap_capable_helper), and checking CAP_SYS_ADMIN against a descendant
> > user namespace, with an unsandboxed positive control, to confirm the
> > decision is independent of the target.
> > 
> > Audit tests verify denied and allowed capabilities, per-member quiet
> > interactions, and CAP_OPT_NOAUDIT suppression.  Trace tests cover
> > accepted, rejected, and no-op rule adds, and normal, quiet, and
> > CAP_OPT_NOAUDIT denials.
> > 
> > Test coverage for security/landlock is 91.8% of 2864 lines according to
> > LLVM 22.
> > 
> > Cc: Christian Brauner <brauner@kernel.org>
> > Cc: Günther Noack <gnoack@google.com>
> > Cc: Paul Moore <paul@paul-moore.com>
> > Cc: Serge E. Hallyn <serge@hallyn.com>
> > Signed-off-by: Mickaël Salaün <mic@digikod.net>
> > ---

> Same comments as in the preceding commit as well;
> specifically,
> * some helper functions could call ASSERT directly
> * EXPECT instead of ASSERT in various places

Agreed
