Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.remote-ip=209.85.160.180
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=fail;
	t=1793636163;
	b=My0rkf/Qd3/sakup4Ekw4PWNRrAzgqFoDX47if+0kYLHf6N0mNyh/AUU6SmaSRvtrrrU
	 4Jml29fxjiPqQbuODn+m4BgfimXcZ3fSwGu7xQqfyveMxN11JlPQkX/KR+ywBeGgKvIVI
	 rzWUWNFhkEep8tyuQb1ZhAfj99hFCrYge3LR1hV0Y4Mzs8eAQculP/3CJjN3ounbBCl3o
	 otDVpl3k1VGc1QfGhyyosdWqwCMtdfCdQPxLXTwGQCm/cnGXw4bgEwP13Aa9+LUoc9R8W
	 RJYAjBPIl9pWJRNnyJ5BK96WjJQuqASPXGmP0f6F7T9j886IX231a5vZWq+PU34xUGA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793636163;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=kxbnR7/KEJxYoo6n9ONzf9qbMiZRUpL+64Guv8cNOl4=;
	b=Stj08B6m3PEPdlzL8kKzOKColm4w6ajUIyNNw0PITKatzrVE2fyzvxtyCXcEETA740NG
	 t56UYyViAGPhGOgDUe27mCqRWq/x/CmXsSaiUyuqkVbnKodrc1Tg5QsOUxkFaJ+1qHtjv
	 5ZmiqDHconio7uheiOFOLQykpWJLh0eqolxtUG0tah9VLt7OhndqguVjiTSMkcGWwtnrV
	 ef4SAz3E/B+ZMZsSFn2hcygKKqOUfGPT/hBSZnmTzsDFZhC+XcYjL/L8GkYLDkh9Sds77
	 41ChED0hTL6yhnrJrlrfhtLAsXKRPmK0fPdZEp+eoqEgGCogNV01tCwhebql1P3MQag==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=I+YbaIDb;
	arc=fail smtp.remote-ip=209.85.160.180
Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BDEA6082636
	for <linux-fsdevel@vger.kernel.org>; Mon,  2 Nov 2026 16:16:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3BDEA6082636
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=I+YbaIDb
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-54492d8a988so461891cf.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 02 Nov 2026 08:16:03 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793636162; cv=none;
        d=google.com; s=arc-20260327;
        b=ZevObjJSl2Z0KN5omswjIQn0KwFl6pfLEROrKWQ6ELBlSZ+7AqwdZbD+2yRkLDSlZh
         ukTE7ioZpgrEawYqP3Px5Yqg9lpIETiRR5MTYMHxM4xCwXjTKMbtqvoiJvXALV8QaHac
         mmAgTovD0x2wuiIb6iySu9MIKsPnqiwU0Rwes3Gq5R4Os703XePsJgNQ8aqKHZ45IOfJ
         hrKRq8cx/ubqWLoP/qZtaPbuTnEFe7AuV+78iX0KVYPvz0KcIwBBN/Z8def5b4lAqUnC
         gHJtYAdh8xV34mqr86f4JCdLh5TZ0Bj9YpoyAwNShvgb4H0HiT27mlS4AYysTcgl1RG5
         vCAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=kxbnR7/KEJxYoo6n9ONzf9qbMiZRUpL+64Guv8cNOl4=;
        fh=K4z214v7ovKrsL8W3q6tnQZnzlTVW19fkFwMvGf4T/8=;
        b=gTFMZmfc1sh58/Qx7etb2yDwsv1SENRzj8EByIOkAaGXMHo6/5ouPA3RLJAAQwd491
         HxcgP4XMwYFPa02G5F2MiIieFMfcZN/v0Gy9Ze8J4Evq9PfVHpDHBXTlXbxrATqR+S3x
         tD0A18uBbAupdzA8SAszfdVEfNRZzoB/SLc4o8qwlN/ZXupXg76GnVEQQpAnyYxf6Idt
         +ZT40tfXOzKJZ2+rmeWiOYVkBm2gkTzOnJl8HZbxrnHM6LRSrcTUuU8tTW1b75qS9PNX
         Cjs41Jt6UHRcnj4WPyK1AFI94+UQhkaQt9xBfueZsXbZyy0JokxJzAQb9HEezKUvJ0NA
         /6tQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793636162; x=1794240962; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=kxbnR7/KEJxYoo6n9ONzf9qbMiZRUpL+64Guv8cNOl4=;
        b=I+YbaIDbOkC+1pgeeuMMjsgTWvq4ZMMQ0fPpD0BiaUjUiuqxfe/w2LKppvC3uhcbIE
         3Et2GKeDvE7V6SDUdJCP6HIL7+J47vLHkAtnK425i2JOD/brFliuvQU3WB6eYpI+zWUd
         hRerwS+OG57otnu+YEfwQjZR+OFKXBT/xQeVfOSMWtshygRwSIp0Uj4ZOKu9QKQxgRvz
         TC3tnq7bWk8ig0Hy4npMh3GGy17F2oNQvPyHtY+NfBuB1zzUO31Sr8+GodYnH9KXCOBZ
         mbHWEu0b4ryQZfTFmPpvLExMOh0FnaJLlhwtUNL+YkBeNDNtoIZ08LCbs97M9rIFLgKl
         nC/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793636162; x=1794240962;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=kxbnR7/KEJxYoo6n9ONzf9qbMiZRUpL+64Guv8cNOl4=;
        b=aujWDfPw0VWyI57cXvx+Cnxg4TPzl9k2/rr6YdLrtj7oplbW4cX6D7hL+EqLVDextu
         wLXZnkbcjlxe3Std7j2utHebwXvHfmST5ZjNS4sE4RXxWzcSxC9xSZg5Sbu9emaZuaBr
         dZ03bS4oMCesAZYnRe6LIjj6SizzyeMEkhx2xpNsIe9r+qYOTjzGXAFsYZfEJtS61EG/
         o2QKHkaxav0HM6t3YyBO5XmpAlGmIf4ribvhTvDTGcamX+NTtKBLoB3A2I9DkHhzAhUC
         xcIixNwGcGABVRq9zdt5Mqr4QuPS1RUOtUALA0NAIlTdBUEAMBuCYcehQue6jx5hNuTF
         LHmA==
X-Forwarded-Encrypted: i=1; AKwUvBzzSB49o/KXHqvliLGH3wjBYBvcrd9JaSfSfzg8YY2JDrNFUpJ1c/qMkVTYMEsB5Vycsw+9mqiDzxEtzkgb@vger.kernel.org
X-Gm-Message-State: APuU4Z9a5kbnL+rhTuYZcLp4XGW199DTPNN9lh+l8O1pj10axoUy2Trb
	+qwFQVAODr05nl5KVXazKF91ZKmDumStXZitJBmGEzyNkedMWrxnisEN+95peM8+ybnUepDjPjI
	EDJt5WXfEn0W+gtmThkZ9vsyi06GodwQH1QkZ7zXS
X-Gm-Gg: AYBFou0613xAF6GbfjE83W9S+LvL2YLDE80638E2TPesxfi91EriaQYk3tPFZ+4NiJs
	TK4RNkhnCyt9kvTWkDZUW4cyuthzKF8VuoWsHFWDVS3tMv+3+BaroASdGBqgiimeJWK4RjedsVb
	FXbGsLl5njx4TfzMc5OGb4EwhsONgLeOd4ZLnutS1eXdnspg5N0uaXayPvCooHnPoePNYqcdEZy
	NP+D3A7uzxcV1mHbmWfznM4vWVQV6f1SBnwZL6nEWPDINTafFYqHH1QcPYgQrF4UaiC1b8y8EE2
	3FiDC/tyk64g6umWfZam0gbu2u4rbYMTvEgJ4CtqXMP3xTiCdvfyWJesTsYW0BiBFJosRZijK8p
	IjNM9SqcuAnrPpqtHVyGSM55rQrfTopsOd3E=
X-Received: by 2002:a05:622a:618b:b0:535:ce3:ee07 with SMTP id
 d75a77b69052e-5414efce383mr93070751cf.13.1793636161515; Mon, 02 Nov 2026
 08:16:01 -0800 (PST)
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
 <20261102080103.6e3f602364747ac6adb13f5c@linux-foundation.org> <CAJuCfpGmHWiu0Hmob-PgnvWAMn=CD0-xgiyGztP+P=OFrwwfTw@mail.gmail.com>
In-Reply-To: <CAJuCfpGmHWiu0Hmob-PgnvWAMn=CD0-xgiyGztP+P=OFrwwfTw@mail.gmail.com>
From: Suren Baghdasaryan <surenb@google.com>
Date: Mon, 2 Nov 2026 08:15:47 -0800
X-Gm-Features: AclHuK8MuiAKeGSAs36EP5lVhajY6U8SuusW-kgtsEu3w40nJ0gV00M_UO0Qj8E
Message-ID: <CAJuCfpGwZqGkOm25=BWAh2QgA8Y00OUmwxsDU+_qOsVsc+KHhg@mail.gmail.com>
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

On Mon, Nov 2, 2026 at 8:11=E2=80=AFAM Suren Baghdasaryan <surenb@google.co=
m> wrote:
>
> On Mon, Nov 2, 2026 at 8:01=E2=80=AFAM Andrew Morton <akpm@linux-foundati=
on.org> wrote:
> >
> > On Mon, 2 Nov 2026 07:43:17 -0800 Suren Baghdasaryan <surenb@google.com=
> wrote:
> >
> > > > :
> > > > : The patched userspace test passed all six cases on an existing
> > > > : x86-64 6.18.57 kernel, with a PID-namespace adjustment. That kern=
el
> > > > : predates ca5480fb53fa, so this checks selftest behavior, not the
> > > > : intended kernel's procfs changes. Separate syscall tests on that
> > > > : kernel confirmed the EXEC-merging and memlock failure cases.
> > >
> > > I'm guessing your bot was using personality() to make the tests fail.
> > > Again, I'm not sure we should handle such use case. Should we?
> >
> >
> > : The concern is pre-ARMv6 CPUs, where READ_IMPLIES_EXEC is set by
> > : default. Nobody needs to call personality() to encounter this there.
> > :
> > : We already addressed this in 0685630fdccb ("selftests/proc: make
> > : proc-maps-race work with READ_IMPLIES_EXEC"):
> > :
> > : https://lore.kernel.org/r/20260808200312.6326-1-kmehltretter@gmail.co=
m
> > :
> > : That fixed split_vma(). Alternating PROT_EXEC in setup introduces the
> > : same assumption elsewhere: RW and RWX both become RWX, allowing adjac=
ent
> > : mappings to merge. The parent then cannot find the expected three-pag=
e
> > : VMAs and the test fails during setup, before testing procfs tearing.
> > :
> > : Yes, the focused x86-64 check explicitly enabled READ_IMPLIES_EXEC to
> > : exercise this behavior. It wasn't tested on old ARM hardware. But I
> > : think we should preserve the existing support for those machines.
> > : Populating writable, then removing write permission from alternate
> > : mappings, preserves both RSS and the required VMA boundaries.
>
> Ah, I see now why handling READ_IMPLIES_EXEC is needed. Then your
> complete fix looks fine. Perhaps we should mention this pre-ARMv6 CPU
> detail in the changelog of your fix to explain why READ_IMPLIES_EXEC
> is important here?

I guess I have to ask whether you want to post your fix as a followup
to mine or if I should fold them into one patch and post a v3. What's
your preference?

>
>
> >
