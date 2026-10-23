Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.224.48
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792760601;
	b=qeaHm9E28Pq4EUwNVrrxZLeIfuFv5M5Haq4Vc0S7XoSBc+UAU8VNiaj0X6F6qbIAK9rB
	 PTy/zWOjTfw8HeQj77y1/Ufim5QnhgclXOEzkcqfLTETAwW4ZK4oNv+wxvi/bZuevpU/z
	 YY6/5WIqZyPBabW5fB6tf7ME6E1KFM2vRhjQsI6k+opKV65CNEviwoVh9L3dzytMe3SPg
	 QnSIygkqAry1Msb6vLwHBd0TIlK3Dj14NALD3h4lM1JzlLv3XSb+O86gVgewfboG0FDi2
	 K5/G9sEoVu+wSgmCqWhP0HMh8QYvWljpCH9wB4JEuFTcuuJzKCjjyGomDLFFimWPHFw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792760601;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=iQzFIinZ0RU6+V0s10kA6laKI1A5m5pCKsbRy5/leiE=;
	b=LQ8+5WiSOt0gkn0X0hcToo8Jm9ymY/wsP/MPO9q6ZKYiUUyx2GG9aOUKio4tcKgvfn59
	 l0zOE8Q5EVUrBMNMBe9UdI2MghE7w0nFqCAONprFkPXTZ0FErEDnS8k8mlxR/2yYZPsEU
	 VDIwQHDiHB9bU3WryI7M5GFn1tHxoaYiSVk3iT9eOE20dWJ8QDZig6KKSu/Cp+tUfjEhG
	 iGo0EwMPv2ktFi1NSlg0Q627y7b8a019KgB0Ikw8ZyXwACWNNLzWpxNKMRjPJLSym9Ltv
	 SDA7cprsBYChnpANwgxjgSG315nBSR1cEXWp263IR53bANUzrWWVFwyzkJkOCSmam2w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=toxicpanda.com;
	spf=pass smtp.mailfrom=toxicpanda.com;
	dkim=pass header.d=toxicpanda.com header.i=@toxicpanda.com header.a=rsa-sha256 header.s=google header.b="c5e/xe1a";
	arc=none smtp.remote-ip=74.125.224.48
Received: from mail-yx1-f48.google.com (mail-yx1-f48.google.com [74.125.224.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E892606A31B
	for <linux-fsdevel@vger.kernel.org>; Fri, 23 Oct 2026 13:03:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4E892606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=toxicpanda.com header.i=@toxicpanda.com header.a=rsa-sha256 header.s=google header.b=c5e/xe1a
Received: by mail-yx1-f48.google.com with SMTP id 956f58d0204a3-6798c4b882eso792420d50.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 23 Oct 2026 06:03:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda.com; s=google; t=1792760600; x=1793365400; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=iQzFIinZ0RU6+V0s10kA6laKI1A5m5pCKsbRy5/leiE=;
        b=c5e/xe1ayA//chxJDjSnZk3+QvQmbFp4ZfKump2DcOl2+526q3uUP/0XBjg9vJs/ZB
         hvZNSrpF60uLrHMIrKEK4YVObYc05+1VxEd4z6kjrPOBK6dhymX/cf7TYn3gdLoekJgc
         SicqUqKfCLSjkWLxN5WI9qyFS7OyhKi3ZRKF+kopDSTHKPkmP6UkdVh8izt2nhv5bhNm
         0ZgAafvnVyAeW3bdFYysisLaMoDA+AYXcGDFahaIci6PEdY3hE2NFQ647YOVhr3PuBfi
         gHFNGUUR2/JDv6S7DfFfGECDqrfn8riK+INtDJhSjdmzez8WsxkhlusAz5qCLTDcEXEn
         RnjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792760600; x=1793365400;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=iQzFIinZ0RU6+V0s10kA6laKI1A5m5pCKsbRy5/leiE=;
        b=RQVvbp+5BaCGIzZFdn/VbYBgWrPX2RYnK6FzCjnozabu66vJFanPyLqL2hh+Qz1LWi
         69OvmJmU9YHqjGC/UZTzgKAz5qlYkBTyfnX2c6opGV/Sk3SJeLOtvzF0bLQeDvXnennb
         iYvD3VQDKsbJ/72VJuSMag0wioyF/2PlrrTTZk6Fsh8kOc/avkr+Hn6D1s5AeF//+8Pj
         JtFKae/FgDwGKrDMgP9CkELgd7nc/8oIJxVSUWRj+99SR0X4swJ2lskTy9+Qn1EyHtck
         SdhxB+P76Sf4aFoWyeGFrNXIHPi5zjwAmNhgq7CVijE+09nNiL42xXSENysdIhUz3Yof
         hClw==
X-Forwarded-Encrypted: i=1; AKwUvByU5WYKyI/7FVG9dvwcJ0losF5MM8WlI+Eqg6OuwEJu/yhsH/5k1lPfhTTXeeG8/D+toAj7h77glmE4F3QG@vger.kernel.org
X-Gm-Message-State: AFq9FYILRF+hbslPdKGJ4oyONkZfsFFvoMFWU0DDq2va6PN3I1I1RagO
	c0IXzh+bYOYk/xLLM4Q/I/CE/BEDDQU8TzPgVtt7513CY+smbhRRlRsQ84UMj1FaBGs=
X-Gm-Gg: AYBFou15q3oq6IkprNz7WNKZsE3Bet4LUwwJKA5aTDdVE2PY5Md+DQn/SW7xPf0jn7J
	ByjdNciDDG/a5FiDwNgoQz986AL0N3FPDwoxrtTTAQAOdaCj1JISjF0wBCjK2p+nX6ynRUwGczi
	KgKDwz1IW+ecsuezUjLMeSNa1tBjijDwPzwwNsB6kC4UzDNXE4vgiUrMxelm+HFRCRop/VQCs/w
	Xy+tGkIOmZhI5avWnNENTKkyrLJVbTwnoAY5wrfZmskek8e5mw73HI+NW7bq3oBuSBvSxXxwOne
	laiDvEHOp/L+YpY72Y1ulppyms4GGL+moPEjFZRHBxX5IfTsCmrKrY6LGph2mjmmbNhf1utIxph
	4I+z8+SWYHQZcJD9j32J4zrXuPydykN1NkVtL7jlYqg5SF97ENVeqiiCfTdv7YcbC1v0qliZcq/
	Hpf0TSorlANJE9q2DLPgvL5SnirGd9DBZ/shS547C65AvfXyIemO7Ah5N7kMbqccWCZ5yqDHqkI
	/x436LLV0HES+rkKaXwtWKJjRVC0J4EM5Lf/8FCQ3yx0nv6hxq0Od2sGr7yK4p9pPEgyBP0zfSI
	+58gfKTV/AAdicB1cw==
X-Received: by 2002:a53:ac9a:0:b0:679:c86f:cf6b with SMTP id 956f58d0204a3-67a35bb607emr1600926d50.72.1792760599602;
        Fri, 23 Oct 2026 06:03:19 -0700 (PDT)
Received: from toxicpanda.com ([153.61.196.242])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-67a3402fc9esm1223884d50.16.2026.10.23.06.03.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Oct 2026 06:03:18 -0700 (PDT)
Date: Fri, 23 Oct 2026 13:03:07 +0000
From: Josef Bacik <josef@toxicpanda.com>
To: "Serge Hallyn (AMD)" <sergeh@kernel.org>
Cc: Christian Brauner <brauner@kernel.org>, Paul Moore <paul@paul-moore.com>,
 linux-fsdevel@vger.kernel.org, linux-security-module@vger.kernel.org
Subject: Re: [PATCH 01/13] cred: gather the rules for acting on a task by uid
Message-ID: <20261023-cred-ids-reply-serge-5b0e9c47d21a@toxicpanda.com>
In-Reply-To: <attYWxUJXfZX0MyN@shallyn-amd>
References: <20261018-b4-cred-ids-v1-0-7bdf2db4ea9f@toxicpanda.com>
 <20261018-b4-cred-ids-v1-1-7bdf2db4ea9f@toxicpanda.com>
 <attYWxUJXfZX0MyN@shallyn-amd>
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

On Fri, Oct 23, 2026 at 07:51:39AM -0500, Serge Hallyn (AMD) wrote:
> Overall I like this, thanks.

Thanks for taking a look.

> > +	default:
> > +		return false;
>
> What do you think about putting a BUG HERE?  It's not actually
> your intent for this ever to be called with 'which' not being
> a valid value, right?

Right, that's never supposed to happen, the callers all pass one of the
three by name. I'd rather not BUG() though. It fails closed as it is, so
the worst a bogus value does is get somebody an EPERM, which isn't worth
taking the box down for.

I agree it shouldn't be silent. I think VFS_WARN_ON_ONCE() fits, it's a
WARN_ON_ONCE() with CONFIG_DEBUG_VFS and compiles away to nothing
without it, so whoever adds a fourth value and forgets the switch hears
about it in testing and nobody else pays for it. It's in use outside of
fs/ already, kernel/nstree.c and kernel/nscommon.c have it.

Christian, if that's fine with you could you fold the below into patch
1? Nothing later in the series touches kernel/cred.c so it shouldn't
conflict with anything. Or I can send a v2, whichever is easier. Thanks,

Josef

diff --git a/kernel/cred.c b/kernel/cred.c
index c067ef72b563..9a3ea6a1b96a 100644
--- a/kernel/cred.c
+++ b/kernel/cred.c
@@ -19,6 +19,7 @@
 #include <linux/binfmts.h>
 #include <linux/cn_proc.h>
 #include <linux/uidgid.h>
+#include <linux/vfsdebug.h>
 
 #if 0
 #define kdebug(FMT, ...)						\
@@ -692,6 +693,7 @@ bool cred_ids_allow_control(const struct cred *subj, enum cred_ids which,
 		gid = subj->fsgid;
 		break;
 	default:
+		VFS_WARN_ON_ONCE(1);
 		return false;
 	}
 
