Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.221.42
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794486841;
	b=IZjXMz4RSW4uHQeK4ks3MQz+aC/w5IXQ24oioAttSOETQCdkFCuPArIQIUh11jNEudxn
	 WsIjmhC68NJzhpjJg5NYeo/RzrRY/NkCCjw1aXJ22w3eLju4x4Ik2lytKhSa9rMG81+hs
	 lmMFykAbJwd+kK09f/Egnna22uUdyY2TV346giRdv375vpqKMqRRYAqKhixf5oS3UVWL6
	 7nfy0+/oYFxnDeLrcb0S7/kJCna4pvDMkpK38123sjS+erFnVVAFe+CffXnEbPIRZFKbc
	 A/RByafl57FZpnW/cKVoIpxm6+6dm3rT0knVZS2oz6jyUq3JJN8p2oKAXRM5MIDgVgA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794486841;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=nKmlHtAvoB0yUtbhRvNeCYmD52AQBw/3HL4TeYlZEfM=;
	b=J8PHt8ncMpJi63RXh8/CxeIuA4SZpn7tSyUTs3rxuxwWca82gQHwh2JloXcp7paS2VRz
	 22n9ZMQ7bW3SX7i1WUC6SV1NnS1eQ7bZa+VToL9fu9usVz3i7v0j5nFCN/eWYgjy5B90m
	 pAvEWPZJ63QFZyrSRBDia3ch2xYI6QTZAFz7IOK+MkLQRQUwjfLBTn5/T34TeqQDZtANo
	 QwYXl9APDQ1uMiIGLFailBDgK2bnrHItM5sNHKZcec7SMWUaU5DLj0lfLdaU7fh+Oax4t
	 aQhL3HkJ3gOX9rJRdu3M1NY0vipqxePivaCI6T15w9J0ldVWTk6n1cewkNB7DvkmahA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ukDlUA80;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.221.42
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CCE3606A31C
	for <linux-fsdevel@vger.kernel.org>; Thu, 12 Nov 2026 12:34:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2CCE3606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ukDlUA80
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-498f5fa4f70so2553353f8f.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 12 Nov 2026 04:34:00 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794486839; cv=none;
        d=google.com; s=arc-20260327;
        b=CS7hxGVXkRpbY3ubTrxu9eDLDQWQJAzh0YbbeXVHpdKGntdLpfIH3iWnNTiM8HMr+Y
         srLDKLkRPL8XX5M8zI9AdB6q7KorK/4wKlOZ1dvUL4GIFy0KwNqpx9GWcRRGOngpD0Ss
         O7kMrYciIqHK3x2uY7u13TJAzS6YLLTWZC8K6zDAPOxdSjr+1n5QAZEmhThXyf9BlkuF
         MJ4I7nmYDFN1Bzv6yK8gn/sbP5cm6CQx/cRjOcxq1DDeyRH5ZlRE7gvikLPF1MHLn5RA
         ap91sL6VF12P7C9ITgwij00Jq4BK7sG/BzX7gQXZ1iphsPUWIrV4uwOp/ddx3bUXJfoL
         7fVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=nKmlHtAvoB0yUtbhRvNeCYmD52AQBw/3HL4TeYlZEfM=;
        fh=OIe0Mz3aJiuUBi9YSkxpfTG6vIBAl+ABaZHP2wn4ats=;
        b=Ea8q4V7SfouyJB9uqC8e3D9/2geaDlzqhuI4XgwsT5ybBPCCxcSvNWZt9Q6ppEeBr2
         SpWA7wdL63cnIHsGhCPcicA1U3hnsFOU1PIRcsKNFJnwiDlhPA5EBY2tDuHD46iIW3/F
         ifmkpOtL/youa8yRHiN+BWV6jJbkbL+zYFUlk7LOvdeFqQshbt/IlmGsMbfIpn4Oxl1q
         HX+UPFF3RVCYV8ozbnklbqJCGFHoXLNOxE5d4RkxSWmmYO/BzTFPvM3ZpeFN+NZbgAXx
         XSMAXRsxyqMpunW/qHEB5TojwSqWRGa0yxlH+mhfxKS8Upkgyxa4m69UMGLx2n8OUAEE
         qQkQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794486839; x=1795091639; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=nKmlHtAvoB0yUtbhRvNeCYmD52AQBw/3HL4TeYlZEfM=;
        b=ukDlUA80+m/vZiV/Ig5PjyV4dpsLQJVhgoByqqX7Na9XtPRe96KKXgb2FAld3B5vxD
         7o7gfyFGeLIu/DFnp89aiUdKjvy8Zq0qFDCcxIwKrdBasaQYYVPWRCWXYt0+VtbUBXeO
         XMauR/2pmRNb0HqxiNROjPKs3GsqcbRyr8Z9488y1RJhXHYKOBALi+wz7wYiv/AHcxtX
         /DQ7dm064H/WLAsFXzKl3piUg5KbukdCRuFLVXxO3JQdsw1VEV47FQFWRBZNB/4rOWs1
         //V3d+Q2UcDrxr5nvPd99RmB9dBOwGrgEtKy74YkGOob3GjE0C4aVgdV7Uc4x62Yn7l5
         4d5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794486839; x=1795091639;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=nKmlHtAvoB0yUtbhRvNeCYmD52AQBw/3HL4TeYlZEfM=;
        b=aBapw7EmvVlI4GfW/uYQqYtBgZDLtClWavLH48khQeJmWZ2n9QyJazBXhf1GSuRel9
         LT9vw7pqhqyRcGgIcq5JsjHMERO2+aj6e984HncJeSlkr49j3UwLFfDcxEwus6vawE7t
         IBpknVxaGSOs2swjfrEhh7MZj4StF5n83dR5TAhoZXtgOjCn2OqhlF4ClbikTpFjbVQ7
         8VsUra1rhtlTcd1z73VU6d7qMUPBTb+tCllUPWB/b2aW1OzpGDcaAzmYLdNR6ri0k72H
         +udbdzn2/XOVHCfZlvCznHo+779SMuJBuwuzSsvM71cAEzcHeGBevk0IW1O5XKV/pJqD
         ZGgA==
X-Forwarded-Encrypted: i=1; AL+hErG9d6PYoWO8FKSaEs53eXQ+FhtX61j2O+JRX4y57QwZeoHY799j3T2eoOGK49GSXFXMr7yDdostlH2TMxbe@vger.kernel.org
X-Gm-Message-State: APuU4Z9vxgod7YcnkE3KD5Qz/qU4kq/5QWFO2Gp0KRBUX7Lbv+xiTkII
	5huX/nMpPEQhbaID3h6xZxd87xsiBv10NwMVVtQ85gHFovD0Orw4V7G2+97YVC4vvJ79N9/8aSG
	u2I5LIm4V1FiNej4bbrfzJbhGNPBa8tk=
X-Gm-Gg: AYBFou0aDYBLIz660Ed6jZhKJq/yfZ/97Mx+AvkPeFWQ0ZpSwhQAGhNycdQFfZdQYFq
	e87/q10t8fx1hinsj3VsszC/+X5O3G0qNPMDP0wRBOllVMLQm59E9EF9y3DizgBk1zAd9+PGFPm
	E1ABhSjOxZEFfjWzeYwoAdPVa4AlGJIQ0l4/wl2YCN6f+VizbsTw2e1iLsHlzw5krRBkcvdlfNe
	+DMvZ+x2hdnYf31nb83R3hjGFuCCWc4X7M3UaG5hI1Ny3CLViQqR1cLR15TJRwcJfJWQWKfhIkT
	6ZgY7tVtOlKn7dlS7NvAGRrPsxdCO+KkQ+46wEedLTsS8OOlc9/2EvlCDxTio2HMjWJ8BMs/q6A
	yhNEqlf+v+ff08h0v6d1eevwWlN4KZzXW+NLhdIdZhZ5aHxfR2mg8OJA2W6l2e5jCGIQWNPnMn3
	2TQlawyI7kgzWlWScys5m5GAibmT7EdQbDLkieEpvlUmbJaHmw7VNyWyg7KqPRW8ORntWGR03UP
	g==
X-Received: by 2002:a05:6000:4310:b0:48e:870:7791 with SMTP id
 ffacd0b85a97d-499c6e96824mr9018890f8f.26.1794486839273; Thu, 12 Nov 2026
 04:33:59 -0800 (PST)
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261111-mason-migrate-et-al-fixes-v1-0-3d2454362e8d@kernel.org> <20261111-mason-migrate-et-al-fixes-v1-3-3d2454362e8d@kernel.org>
In-Reply-To: <20261111-mason-migrate-et-al-fixes-v1-3-3d2454362e8d@kernel.org>
From: Nhat Pham <nphamcs@gmail.com>
Date: Thu, 12 Nov 2026 05:33:47 -0700
X-Gm-Features: AclHuK_RzWviJR9jmvlK9oBAFygOMVFIIWMHi8nCFGJAgeBhxOkAfyb2dvI3XUA
Message-ID: <CAKEwX=N-YqgrZTpoxLoKYTnxT2QR4Z4_ohw+SBR+M7CErBDbOA@mail.gmail.com>
Subject: Re: [PATCH 03/13] mm: cachestat: restart the walk after each entry
To: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
Cc: David Hildenbrand <david@kernel.org>, "Liam R. Howlett" <liam@infradead.org>, 
	Vlastimil Babka <vbabka@kernel.org>, Mike Rapoport <rppt@kernel.org>, 
	Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>, 
	David Rientjes <rientjes@google.com>, Shakeel Butt <shakeel.butt@linux.dev>, 
	Andrew Morton <akpm@linux-foundation.org>, Jann Horn <jannh@google.com>, 
	Pedro Falcato <pfalcato@suse.de>, "Matthew Wilcox (Oracle)" <willy@infradead.org>, Jan Kara <jack@suse.cz>, 
	Johannes Weiner <hannes@cmpxchg.org>, Zi Yan <ziy@nvidia.com>, 
	Matthew Brost <matthew.brost@intel.com>, Joshua Hahn <joshua.hahnjy@gmail.com>, 
	Byungchul Park <byungchul@sk.com>, Gregory Price <gourry@gourry.net>, 
	Ying Huang <ying.huang@linux.alibaba.com>, Alistair Popple <apopple@nvidia.com>, 
	Usama Arif <usama.arif@linux.dev>, Kairui Song <kasong@tencent.com>, 
	Balbir Singh <balbirs@nvidia.com>, =?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>, 
	Kiryl Shutsemau <kas@kernel.org>, Yu-cheng Yu <yu-cheng.yu@intel.com>, 
	Dave Hansen <dave.hansen@linux.intel.com>, Dennis Zhou <dennis@kernel.org>, 
	Tejun Heo <tj@kernel.org>, Christoph Lameter <cl@gentwo.org>, Peng Fan <peng.fan@nxp.com>, 
	Josef Bacik <jbacik@fb.com>, Chris Mason <mason@kernel.org>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	"Borislav Petkov (AMD)" <bp@alien8.de>, Mark Brown <broonie@kernel.org>, 
	"Dennis Zhou (Facebook)" <dennisszhou@gmail.com>, Rick Edgecombe <rick.p.edgecombe@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 11, 2026 at 11:14=E2=80=AFAM Lorenzo Stoakes (ARM) <ljs@kernel.=
org> wrote:
>
> From: Chris Mason <mason@kernel.org>
>
> cachestat() can leave cached pages out of its counts. This happens if
> the entry that the call has just counted is replaced by a larger folio
> that starts in the same XArray slot.
>
> The issue is that filemap_cachestat() walks the page cache under the RCU
> read lock, so racing concurrent collapse/split is possible.
>
> Thus, an entry can be replaced immediately after the walk has returned
> it. When that happens, the next xas_find() skips the sibling entries that
> point to the slot of that entry, since ordinarily they belong to that
> entry.
>
> However a concurrent collapse_file() or __filemap_add_folio() (when
> replacing a shadow entry) can store a larger folio in the slot, in which
> case the sibling entries belong to the new folio and the walk still skips
> them.
>
> Consider:
>
>     cachestat                         collapse
>     =3D=3D=3D=3D=3D=3D=3D=3D=3D                         =3D=3D=3D=3D=3D=
=3D=3D=3D
>     count a 64-page folio in slot 8
>                                       store a 512-page folio in slot 8,
>                                       with sibling entries in slots 9-15
>     xas_find() starts at slot 8
>     and skips slots 9-15
>       /* 448 pages are never counted */
>
> Also consider:
>
>     filemap_cachestat()                  __filemap_add_folio()
>     =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D            =
      =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>     counts the shadow entry in slot 0
>                                          slot 0: a folio of 32 pages
>                                          slots 1-31: siblings of slot 0
>     xas_find() skips slots 1-31
>       /* 31 pages are never counted */
>
> Essentially the fact that large folios might be present means we cannot
> safely continue the XArray walk, and must reset the iterator each time.

Hmmm, cachestat is inherently racy, for performance's sake.

OTOH, it does seem a bit silly to undercount purely because we race
with an operation that does not change the answer (collapse/split).

Johannes, how do you feel about this tradeoff?
