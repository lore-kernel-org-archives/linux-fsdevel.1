Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72C57277007
	for <linux-fsdevel@vger.kernel.org>; Sun, 17 May 2026 09:13:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779009195; cv=none; b=GIqBqzPt5mX1ZYr6v949pUKCN+FcGL+/QHgQcA/g6V4GX79VjUeKaYF5J344NTUe9NU0NdTqU2bmmeKOkjKSynVJxdYXGswbG9XwWw0F/31soBmINXr6Q64sdpZUZT6hYmW1ZehbkbGQZUw3SrvUPCZPg9ybq5/BpFzTqPAs6Vc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779009195; c=relaxed/simple;
	bh=lBG5CVff6d0GKuDcYLZ8P+K2P6MGTd0mAfUDbRzcmyU=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=PqYRbGmT+R4mQTTCX1fPKvaGn1jJ1nmljwRjT0aSjyYf8wifUzjjhs/HPcq8SugDgMNPvph8q3HSYegaeYPigPlqziKOpOiKwtUDUrb3mDUPk+ilzfRtfPxXgoSUxhEDWuwUFf6f6n/fpDxYbNKWa7VRNvxtISnRMD92Mj132Sc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dilger.ca; spf=pass smtp.mailfrom=dilger.ca; dkim=pass (2048-bit key) header.d=dilger-ca.20251104.gappssmtp.com header.i=@dilger-ca.20251104.gappssmtp.com header.b=Jigpsc+r; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dilger.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dilger.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dilger-ca.20251104.gappssmtp.com header.i=@dilger-ca.20251104.gappssmtp.com header.b="Jigpsc+r"
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-c8173b2af32so998304a12.0
        for <linux-fsdevel@vger.kernel.org>; Sun, 17 May 2026 02:13:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dilger-ca.20251104.gappssmtp.com; s=20251104; t=1779009193; x=1779613993; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hGy6d3fU1UxUZ4KLxRq3UUs4B31b5z08fFv5opx/6/Y=;
        b=Jigpsc+rCAJCu6iYzAbRTi0n0wk8+/K5iNpTFF56ALTVR0HgKRAilRGYM3gMCFVQTw
         nA2Qih/PxOCSgxQjnoIBBxZoFXabpOZgZzQq+W1qiaJfm3N/h9YzhHflsf2eMW/7cAgF
         iO+Ii8SvTCQJzywKu7k+HocdfXX+2MncARt4adynKoHipVc1ulTGMwTIJEAg1wzViu/0
         4sfpzlBwYgdTyLr+tPWffrxj4lAQGak5K4BoHo0VRhKh8bmigbsz/VMP9sygQMG8HQw+
         BVltt1ql3kQbgNfizOPQ1sPdy+uqPnal6j/M+ae9K2krUGFC2J+znzHpdm3L/6cdJ1YU
         ytkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779009193; x=1779613993;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hGy6d3fU1UxUZ4KLxRq3UUs4B31b5z08fFv5opx/6/Y=;
        b=fOD8JbgGr7p41SI4IFanWeqTEd1/ypq5yCI4NKz0KMGOfi52JReAA/RzXQ2Z+X8Kyk
         pbtmkAqAYqr+NmYkj8Vr9TAyZuUFjoQ1XrmRRokofAI0dhlKzVZ2CVFW6t63a5ah44g6
         6zKpFHRXuxLA3niN44hCIgeYvyP8IeepkQMLaZlgGSGF77Duj749w8SzlQoNwhibxgj7
         QnvGlbAl3q1+ZettmSaPQ/7P4uv2woyi3aU6ljP/a7U3ml5n9tx8O5Afr4kzdl78PUyD
         beno8S9xVgRb3y9Zo+a3nOzPx2N5prOdcNOw51IuPoXQPCeN1JyZNpd0LCVNXP+aahFz
         BO3Q==
X-Forwarded-Encrypted: i=1; AFNElJ/DgEQQ8WVMYJl3fjYWbgIDRhUqieIOX3ar/mO1RM5e3+LslSCFnVvVxqQ/VzURkC9pXDg/T4D6pzmxDdUT@vger.kernel.org
X-Gm-Message-State: AOJu0YyRVjYCm3a7vLN2iO7SrqjwAZYXGC3XVRfp12GccM17/AE5GO9m
	IWwDXBVQsslEBt98FMlOHs68CdroTaKpcN3KK5olAo1GQRynzl262XdZUs3MlIEYCu8=
X-Gm-Gg: Acq92OHK4VQ+XPtRigp4AWWLQLIvf3zFbmDY69LyE7AcNovNlz850wRxUN22bkp/ulu
	xU704vHRTKeyj0vS3+qiGFmCIk+pMifCL//sf3QlvV8CVOEN9uLfBLzmOxU4HH8dsENT3WMoluf
	MmmNjIDcJCi41rCyYmbNXaMqTYBCCDvK9NOhY4dA4XjVjarGYSH+CPzjAnufzISXGfniz6Hjm0X
	d0yHrsQodTCKtfwoVOlXT/1kConvzzGRDAF0KWSVlsLPTZtaGnHMhGBLXqf7/MqTrUAZKaL3RRQ
	J1ltV89gXqTXWA+3DHFpkzF9DSs4DYL0zpuyCB+u9lLPENjnQed7Nx5ZGFL/QA4Vi5TS0p97K4F
	yntHI79pxJ8SS1i9LCcAKX+P01EOfDhUueqJrHMBJvHWIY3VaNeUW1yhQTt4WohrFgWJ7VgGe/t
	4yJ186BlqZKXQyAK2VahSZ9WV/vqiTPEltCFt/HBm1Gn/s4gAg8CDYUVoQyKlgbh7BpHIq49vMY
	76Y
X-Received: by 2002:a17:903:1b65:b0:2b9:8d39:5e87 with SMTP id d9443c01a7336-2bd7e7bdd94mr122002325ad.10.1779009192744;
        Sun, 17 May 2026 02:13:12 -0700 (PDT)
Received: from smtpclient.apple (S0106a0ff70715ac6.ek.shawcable.net. [174.0.84.146])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2bd5c0600c3sm111886495ad.29.2026.05.17.02.13.11
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 17 May 2026 02:13:12 -0700 (PDT)
Content-Type: text/plain;
	charset=us-ascii
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3864.100.1.1.5\))
Subject: Re: [PATCH] err_ptr.h: introduce ERR_PTR_SAFE()
From: Andreas Dilger <adilger@dilger.ca>
In-Reply-To: <20260516094242.77d20c92@pumpkin>
Date: Sun, 17 May 2026 03:13:00 -0600
Cc: Amir Goldstein <amir73il@gmail.com>,
 Miklos Szeredi <miklos@szeredi.hu>,
 Christian Brauner <brauner@kernel.org>,
 Jan Kara <jack@suse.cz>,
 Al Viro <viro@zeniv.linux.org.uk>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Nirmoy Das <nirmoyd@nvidia.com>,
 linux-unionfs@vger.kernel.org,
 linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <56380C61-04E4-403E-B721-F9B62DEA5D56@dilger.ca>
References: <20260514200129.94862-1-amir73il@gmail.com>
 <20260515193010.056ef472@pumpkin>
 <CAOQ4uxjDeF3uDe=OTVZ3fK65dF148FRUvPx5fOqZpoFuGUsmJQ@mail.gmail.com>
 <20260516094242.77d20c92@pumpkin>
To: David Laight <david.laight.linux@gmail.com>
X-Mailer: Apple Mail (2.3864.100.1.1.5)

On Thu, 14 May 2026 22:01:29 +0200 Amir Goldstein <amir73il@gmail.com> =
wrote:
>=20
> The check for constants may be fairly pointless.
> One of the static checkers may already detect the obvious fubar =
ERR_PTR(EINVAL). =20


Actually, I just ran across an issue that checkpatch.pl does *not* =
detect
this "obvious" case.  It complains about "return EINVAL", but does not =
say
anything for cases like "return ERR_PTR(EINVAL)" or "rc =3D EINVAL; =
return rc;".

The following patch fixes checkpatch.pl to report many more such cases, =
and
has very few false positives for checking common error return =
assignments.

diff --git a/contrib/scripts/checkpatch.pl =
b/contrib/scripts/checkpatch.pl
index 70c78a3..e3fdedf 100755
--- a/contrib/scripts/checkpatch.pl
+++ b/contrib/scripts/checkpatch.pl
@@ -5795,11 +5795,12 @@
  		}
=20
 # Return of what appears to be an errno should normally be negative
-		if ($sline =3D~ =
/\breturn(?:\s*\(+\s*|\s+)(E[A-Z]+)(?:\s*\)+\s*|\s*)[;:,]/) {
-			my $name =3D $1;
+		if (!is_userspace($realfile) &&
+		    $sline =3D~ /\b(?i)(return|err =3D|rc =3D|ret =
=3D|retval =
=3D|ERR_PTR)(?-i)(?:\s*\(+\s*|\s+)(E[A-Z]+)(?:\s*\)+\s*|\s*)[;:,]/) {
+			my $name =3D $2;
 			if ($name ne 'EOF' && $name ne 'ERROR' && $name =
!~ /^EPOLL/) {
 				WARN("USE_NEGATIVE_ERRNO",
-				     "return of an errno should =
typically be negative (ie: return -$1)\n" . $herecurr);
+				     "return of an errno should =
typically be negative (ie: $1 -$2)\n" . $herecurr);
 	}
 }
=20

Cheers, Andreas





