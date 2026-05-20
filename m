Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD8893546C6
	for <linux-fsdevel@vger.kernel.org>; Wed, 20 May 2026 19:55:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779306939; cv=pass; b=Gu4/nnU1tjS+9L8FZTDssubOmBnlyqLx9NFJ7pHSGt/tELqh/stX1j1TWNV2PjeJtO99qroKBhQadVruwKJOHNA5h1PuYFmxsA4A6r5FEtJZZtAPpQt2urZe/D9H9DBpbcSctkjMSjyDRvN0AdjyGIAEAZqH+Wm2A6uFPIRot2g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779306939; c=relaxed/simple;
	bh=9Q34cFVQWLWAAn/q3aUqVa8EHeIay+4M9jAXGYL1/Tw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LJDfWvb3X7M/1Ruf5QMK8MG2vpDsvFVkLw8I0BmexFT6ss0P6UyXUae/CKL+XHXJS1DGyNxuEv2d9zF9O8g1eVxK633CvAJ5YGJwth+aIvw4CLs6+rgt6zPoBHhc6/65GJIAAkzXbdLyILRrG5lB2JUQMR1jOaPzBqzzvuKAWeM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XgO92rEf; arc=pass smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XgO92rEf"
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-67c4aaf76ecso8927923a12.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 20 May 2026 12:55:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779306936; cv=none;
        d=google.com; s=arc-20240605;
        b=fwVMD9zgRSdywYpU3ciQGD3tV8DGdHxFAMQyGej7WzqxaXATQLCTDPTW1IGdD3m7AB
         aaJFGkdq94EpYx3RRQ1FtEHOfj5Wr0yrm3CbIs9zunEXolIC1Gq6JKb1yW2YU5OyRAI+
         0TDNkNz/vNwjA40fPEKGyqgYo+j/PyjtMYvi4uv0jSr6ujbAe+Gr4fXYMP6GTEA7njpW
         mPjIe3uidgxy5IPDuvARDSaYhkoGW/lddS7n0LKPbjPl5PgwzLqdxJ1u8tEz92pAXi7l
         bBR/Z9lN+vfPO7GVau9hciGHxHE3ZIaAxpKckTi1zXypK072Fg1ylEP5zerq8nxWgAPa
         jTTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=9Q34cFVQWLWAAn/q3aUqVa8EHeIay+4M9jAXGYL1/Tw=;
        fh=QgLyxo4vXcm+jJd+48wKj+V91K2/eI+OpG1gYcKzyCs=;
        b=LUEIz9IJvdDyaLM4cZLDFlW9+c+Ua+bc+mEP/6rnlfybR2Q9K5umEr+YzBSXfr5Y35
         53Q+mAVb16BCXuGxK/HbpIFVUdxizXU1Kj6ySIgcFyqhdaauMm1wN79bkDmrSA+kJb/Y
         8ShId0naZluCY3x2ez9aZPoUPnqQJc5Q2QSlCHCNMW6zvx1cSKMeqIRHIZR2uqCTu2K+
         AVdbwdNB7ZvAtRLef49u4S18yNWYJypprl4rfkFtBZ/qfxAsg4u9u99asKBN4V3jbQ9m
         E6tWxqNqb+b1HH3O4jPOuEHXKrWtLtN2qNLKuMsAhAKn/iJoKTx4YyxL5iPnRT0k1XW0
         l5fg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779306936; x=1779911736; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9Q34cFVQWLWAAn/q3aUqVa8EHeIay+4M9jAXGYL1/Tw=;
        b=XgO92rEfFy9CwImw9GqyFhV6kVoYpkdlqqqucy6G3ZR/ZiZexZx+Fc/Wrcz3xiBekD
         mURAZbQmrtalQ9GBW/H5U0K3g4RExhJhpdMk/ucb+HGP+FqSW5GFyce/5109ZByBiZo+
         qm2bOT4hVUDN8BDwBWJ+yf8XEb9K8S1cziPEWQ7coKS9dyq1csjXfi9BnDqr7ocBhFcB
         ftUXr33DfLmDTweDm5f3sIrP7rboZPHvM1nTeA721k5buf4EJZuUzlDH5IaJCtqesydK
         3iubGp7Lb0uYezivAVeyo/6i9qmPYTJWkX0bh9XfEZ3RIFzd0ddCK2x1ffGkWE8ZF5Ay
         5xqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779306936; x=1779911736;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=9Q34cFVQWLWAAn/q3aUqVa8EHeIay+4M9jAXGYL1/Tw=;
        b=O7FRgiGw5WOcNjsWus0VMbUnQVhPjeiT7wcdsC7q662KKpGjYnaPU+IVH9yAYEZeFB
         TyhNMqI3ZL7FcVepkYoLzP+NWbX91TPu+zy3PjbQPrMbl1k8rsulzpAR7Ij59G0pT5m6
         3L6m+5ZBw9or2DXO3BPiHS4u+EiGMzCNDNeQG73vIBS70mvzF0r9g4LfofLGpWluqlQt
         D3cTYhW0/Riywm8UWh8WmKAUPmeMlmw/U8oGxMUhyHW7S1lp6ZcnZIu2fj/WDwA1jS0X
         k6ju/kIjrB/yJje5rs7Em9cUzVZ+ILPv46SUbJZDCMLyYrK+k6z0xDKRxAnXKsGUjVXm
         9cOg==
X-Forwarded-Encrypted: i=1; AFNElJ9Yl62WNAJ2YOGG0ILuJBi4vKdbT5iG/MwyKBRSAM+1duOSL+wxSkqvNiCQ7Fxbugl6+6udUTtXJNnPwk1K@vger.kernel.org
X-Gm-Message-State: AOJu0Yw5BKapsptZedKiyYlD8j940ypRR1481TULZwMxX+KaQz24PO/Z
	h2Uid8v+j4yiSnvpnMflHCBkSB4wPI+lY4q537eu87Z+LclttqiYiSXDKzlcuG1GoeuxHJdk+u5
	HLxWVe0ZVmNs3zJi370LjJj/94CBnHRY=
X-Gm-Gg: Acq92OEanuVNAL3BpEnmak0T30Zj8FJVVgu+mzvHmHDKK4qL909Mu9J8X5ist34XR+q
	VAH3n4Gm6jDpN1hl6JWlqmeIkfMBL2UKM5M0c0uQ+jsMisblroSsxBVloMEQmtTHlb+477r+3a6
	a/KSryPmyph7qshLgJ4cZJfk+uXFj8MfyH5y45myMOftg+Q/2wPzR8MEj0wt3k2HwaNg1261Fuy
	3FjIc4mHmRJ4cnp39zrF7jyuk8WScU80/GX43zFRAPmmw6gy/vdHsQD8rVv9xbnzqKZfLat4QNN
	qkUriVzUZ+SNo0OVqbW9Fuw/ZfWRn0romo9W4db8Zw==
X-Received: by 2002:a05:6402:24ce:b0:674:5b2c:d42c with SMTP id
 4fb4d7f45d1cf-683bc4b1262mr11201124a12.3.1779306936107; Wed, 20 May 2026
 12:55:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <177922944800.2436629.7011047808676668088.stgit@frogsfrogsfrogs> <177922944866.2436629.1081840703046716342.stgit@frogsfrogsfrogs>
In-Reply-To: <177922944866.2436629.1081840703046716342.stgit@frogsfrogsfrogs>
From: Amir Goldstein <amir73il@gmail.com>
Date: Wed, 20 May 2026 21:55:24 +0200
X-Gm-Features: AVHnY4IDRYedZ1G4VMH0xqPAsGnqhnK5ihLw1HmufQQj4kZHRWeB9bEo9aat1HI
Message-ID: <CAOQ4uxgnJbbTBup7UDh4R0AStx5hL0DYY09Fk7g9ETJehopMmA@mail.gmail.com>
Subject: Re: [PATCH 2/4] fuse: store backing id in fuse_backing objects
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: miklos@szeredi.hu, linux-fsdevel@vger.kernel.org, neal@gompa.dev, 
	bernd@bsbernd.com, joannelkoong@gmail.com, fuse-devel@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 20, 2026 at 12:28=E2=80=AFAM Darrick J. Wong <djwong@kernel.org=
> wrote:
>
> From: Darrick J. Wong <djwong@kernel.org>
>
> Make fuse_backing objects know their own id, it'll make tracing and
> recovery of backing ids easier later on.

The problem is that in the context of fuse passthrough
backing_id is just a temporary integer name of a fuse_backing object,
but fuse_backing may outlive its backing_id (e.g. in fuse_inode_backing()
and in extreme recycle situation a backing_id can be reassigned a new
fuse_backing while the old fuse_backing object is still alive.

This only makes sense if backing devs ids are never closed, so maybe
only if FUSE_IOMAP and FUSE_PASSTHROUGH are mutually
exclusive (did we do that??) and FUSE_IOMAP never closes backing ids.

Thanks,
Amir.
