Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.160.180
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793640114;
	b=M6iRHm5Ero3N7V/8N+3eF/qtO12tLJmCLTDqveVKzP9AMchwxtWSBUaq23UyNuOUiFCB
	 CD2VCv8xNR6lX6dVUIi6cK1LCr1G6+jIfhsZNzCqf/TXrTtjFTN5SAcFHpQzk2XSMaUfC
	 AoRmyUCB8pHxgjxmfO7ceA47TYESkyB4eHi1etjhxkTTMbmAwYnTaDISIiPf2r52a+fLL
	 Wc1JlH+q8SY2eVAG33QmG6xXWTyuzq4a+U032HHHjUvTjBYqLj5J+Qh5cnlGadaoMqzlm
	 +U9Cn4P8PUQJPLLCaoHUnYMWoVHXN4JU/rGdaqaKs0lSrEOpsREjwsU4/OfPnglt5NQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793640114;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=Pufnyo/dEDOXN1GFROHvouFby0UdETgJWNBykJQU2Hc=;
	b=o4Ih+4upkzoNeH/GEFCog3py22zBZ5z7eBr50+7APE5R2h10nNMRyWLW/sJ0KkPx9hcq
	 ZXm8lv/bOWrJVFTyXi8Dfyv7J2yEOOd3iXWiqPEI0gQFbDUgGpn5IuWttMI7WTQs4bn2z
	 qAsGUayT2LsbjYhqBup2vqJxutv4l4mLbtK4AJ62acBCnzxZRXIRp186VsfVYLMA+UUJA
	 r/GFmIqcEhXDrYAodH91vulrYwO9GUeaxi6xe+JzRWuFv3wXvqoF+EXEw8DFOuIHB85KN
	 Acfehmk9KHxHrc0fwRAg1fDsSaUZk3FVXHcZbFDZOc3cWCdiYhtqTUuyip51fPhBJzQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=KACIx996;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.160.180
Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BBF9606CEDF
	for <linux-fsdevel@vger.kernel.org>; Mon,  2 Nov 2026 17:21:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7BBF9606CEDF
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=KACIx996
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-535f598d126so477631cf.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 02 Nov 2026 09:21:49 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793640108; cv=none;
        d=google.com; s=arc-20260327;
        b=mejT1Nzgra9AdySP893H+FjEl9eyFeVbt0Ah6XD3jKWvHdJg22iZ6JhBo/lXhycjyO
         wWlFlChlOJaRFG9YzLNNlFmXlZl0003TmsXEbfkKpqwTzVwuoNXfmZ4NkFmGNapKNgOi
         37OoJO/WjS4+xXLkgxkewuETHkahNt0f9d1VqGId109oz51TeEZ94sIZhIaoLd4Mq4cp
         UOYVQFooXJUDh3O0vdHDNmo0rFqSDXGHH2bbZQZFWwtodnGGq39fDFSFWnknl/yiiUN3
         AcxE4IPvGBDWyH7mJEQ1XY1JnweblWvZiqx6GDxFN2thiH28GvTjnwrHidL9UuLDYU8v
         GtyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Pufnyo/dEDOXN1GFROHvouFby0UdETgJWNBykJQU2Hc=;
        fh=ROs8AXNIolwEiFPVLuXAmAV+ej7Iqn5h0WBWAsKTZFI=;
        b=AkyjTvuRQQ6MRc/Ktjx0gthqaksjVTcXzTUVb1LDoutf5nWrxF0eujOj14Ul8kwkj6
         iew06M9zVL2+n9Ve6cDWa7p5WkKea4XlGF/dZjuCTL+QjjeAcMO13YNBl/WsjsYFSgi4
         MHEHmpJovw5bgVZEK5BW7ASZ1DVf73Q0u/mZiY6vYgSIwH3UkHtvw5SLH1E/p4Ee57PN
         OEtdSjh9UvsPWeMgx5K1QxDVH2Pp+m4eREkqjIhZ0eRnwtdZQ2SQBGLuuMx3ExhpcMEl
         9d0YbMGgbaUhdLJ++NfFcD7WxclBJDu2jetMwF3jONS02YvdYaDIpvMSpzaI1p+DxVnM
         KyYQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793640108; x=1794244908; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Pufnyo/dEDOXN1GFROHvouFby0UdETgJWNBykJQU2Hc=;
        b=KACIx9963F7+4FOg5xffkZ8NHTpNRv1DH18778aING8dHlF7JmravQUnFuOQrCOGtA
         ansdFCifjPZdeWuiwqOwpUhKyXG4vO8suKigpWw/jXjtxhzX5LEAREdeUKufJKQhgdQ8
         RvF0jQh8zu2V1euX9OMU1FwyeZ3dmtUfsixesLgRkN48nBLrnw8kRmAt3oxtmhTSrMF9
         BG5uPRpNO9wA6YT60v13yXT2UvwtdE8NxO815H3KN5tM/cEscAjd8pD+fGC1BTAHHJ9R
         aeOnfJ4Tbog0ybixpVaiPVqofTYisoxsTrBwnwD5pXXkLuXVSvJEcpLlHhu5xuu522pf
         l0LA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793640108; x=1794244908;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Pufnyo/dEDOXN1GFROHvouFby0UdETgJWNBykJQU2Hc=;
        b=Br1c6AmHP8oPABkTRCNDjkM3/cyPE0SQwd1DcL6Adga69tGa6pH2bJFuoENj7pwplM
         Xz/R6eouPhSDEA2bc9t/0MmUmdxqsbT9Z1NCOsDbGmJ+MjCdGzX9ROWjHkmA3EP4F6Ph
         wOmYScwi3y7U6QhL+2cLJv9M0nG2d9LiuNDxJzqtO1ndFtKEuLk8RG6TBUoRNZT3nfZ0
         9USJXo85tPy0QzRGSyjfxSGx/WkB0iAnNvKEOqPTsxz2LnSTvJTtzfgpf6sDiJBlKjij
         wExXRgFKOFTVvvGuTXCZI5XOX9u6ed4tvWozRgoGTYTyz41cPjN7SV2SqudlVL4bGdPd
         YJXg==
X-Forwarded-Encrypted: i=1; AKwUvBwJ7iTe6XuNRRZ2zpRsYexQbkqtXMS0ORkYZYSANqKrXcyHYIph+x8piwXk6YuA0WiYtmsmXtlQsmicebcp@vger.kernel.org
X-Gm-Message-State: APuU4Z8vJBa7wI7Wz/rD67erj/0jAbUoxVgIipcfJ5dw5TVpzAJ1eObX
	KIt0s2MUrIEf8dXmT9LmCSb/m9AMELGLHuGjFv+M6SHmT8l5AAfd5NXTquymWTeG0DcW47uaQ3e
	VRtY2rOWqsEZ6E4OpJg//35m7M89ud3l+lLLJ8RNG
X-Gm-Gg: AYBFou14EO4tWDNyQrTiCZB4byDf8LLn2cOLhd4ZaIBmh8GEy1NURUhsfh6jV5ePdVJ
	fKms2mSD/QLT3j0us5MxHtclLwuDhYY1xxL956uswJmW90TKmPLTeS6PuAAajpyVu5q1Cb//cle
	1xxZcgor6vOZVN+iZoywCa44dEbm7ZRYodKJydNpxzMyOklQbNHSQiPSK/o12Zg/hESn4w7ktzS
	XFQhMa/xuONnwP5QOn+FB/2gAdU/wfwYz58kKDw8WGKWrBXgioA8f1Kf/C9p5le6bUdo4aLnFXx
	aGnUs8fQ3nVBEVqkXaDPEmcHDtnsxgET3nj6zaPbyLSWN2Tv7ezdL7YGjJ/xQxh/dKcybXqHIl7
	5gsjRpxnPG6MqxyaAwH5QBIadROXva4vRLmPH
X-Received: by 2002:a05:622a:c01:b0:536:78de:775f with SMTP id
 d75a77b69052e-5414eed1434mr90915071cf.15.1793640107803; Mon, 02 Nov 2026
 09:21:47 -0800 (PST)
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261101154503.3203036-1-surenb@google.com> <20261101110100.90796bf33ef50307a7698dca@linux-foundation.org>
 <CAJuCfpGmPLBRhHa_dmyP10QzyRyvcWMYDLU0+J9t-RCLBsTaWA@mail.gmail.com>
 <20261102080103.6e3f602364747ac6adb13f5c@linux-foundation.org>
 <CAJuCfpGmHWiu0Hmob-PgnvWAMn=CD0-xgiyGztP+P=OFrwwfTw@mail.gmail.com>
 <CAJuCfpGwZqGkOm25=BWAh2QgA8Y00OUmwxsDU+_qOsVsc+KHhg@mail.gmail.com> <20261102090125.58a2e80d1669c681c33ed20b@linux-foundation.org>
In-Reply-To: <20261102090125.58a2e80d1669c681c33ed20b@linux-foundation.org>
From: Suren Baghdasaryan <surenb@google.com>
Date: Mon, 2 Nov 2026 09:21:35 -0800
X-Gm-Features: AclHuK-DjqV142Ud10paqFStz21PGZUYRyNelFGZhjzHwoB2M_64kIh8h-R_AJQ
Message-ID: <CAJuCfpGvLt+QDw+n0QnZmBqryMrX+SRZJUTqFhVNR-EXpXBRpg@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] selftests/proc: use RSS in /proc/pid/smaps_rollup
 tearing tests
To: Andrew Morton <akpm@linux-foundation.org>
Cc: david@kernel.org, ljs@kernel.org, jannh@google.com, liam@infradead.org, 
	willy@infradead.org, paulmck@kernel.org, pfalcato@suse.de, 
	usama.arif@linux.dev, vbabka@kernel.org, linux-fsdevel@vger.kernel.org, 
	yi1.lai@intel.com, oe-lkp@lists.linux.dev, lkp@intel.com, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 2, 2026 at 9:01=E2=80=AFAM Andrew Morton <akpm@linux-foundation=
.org> wrote:
>
> On Mon, 2 Nov 2026 08:15:47 -0800 Suren Baghdasaryan <surenb@google.com> =
wrote:
>
> > > Ah, I see now why handling READ_IMPLIES_EXEC is needed. Then your
> > > complete fix looks fine. Perhaps we should mention this pre-ARMv6 CPU
> > > detail in the changelog of your fix to explain why READ_IMPLIES_EXEC
> > > is important here?
> >
> > I guess I have to ask whether you want to post your fix as a followup
> > to mine or if I should fold them into one patch and post a v3. What's
> > your preference?
>
> yes, please just prepare a v3.  I don't think bot will be offended.

Ok, I'll wait a day for others to take a look and will post v3.
Thanks!
