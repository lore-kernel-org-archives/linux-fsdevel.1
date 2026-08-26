Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 061BF3E5588
	for <linux-fsdevel@vger.kernel.org>; Wed, 26 Aug 2026 10:52:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.181
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787741538; cv=pass; b=rOWcqh5yeZTDw240tfBwLaaA87QaonqIt2TTAt4Ke5Yom5s7E+ZbXCIeFVudXGM+SWhd62Z8tepTOzAI7/RSTN5rG2spGOcw9+MNztjZCmw4Wg5PoUJKhiixBVNbiUfqxjik4l6NEtGfzLUuTngamwkqpMfwqDT4l7ohL3Ra7HY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787741538; c=relaxed/simple;
	bh=W+E2yob3VC1nC5T5vDlsuCeEoBLkoFNoqRZ0DeBs89U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Dc8+YVaXYrb6FSvGrcbSw653u/ejzkibTdaPCZ5Q1+8PuCMeB2ZAX0BIpAbXD4Gp1tHV9whsD586WATzgQpW0ZE9Z/dvOApG6z+k+YZ/3Q7Twa5UykUt592ONHcT71vc5lCgGpIQ+P4lki9oLc7R7CVxeBsgdsTT2bqk2JLb+qw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=Yy4F1GcO; arc=pass smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="Yy4F1GcO"
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-5218927884fso8155311cf.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 26 Aug 2026 03:52:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787741521; cv=none;
        d=google.com; s=arc-20260327;
        b=juOTQJzp/DEww3JWEg36hIrALv0Y0G2t9OCxgyqnsPnKhqgbljPIJhAjMGCqKAx6T/
         QHqaV0KLWNMkNIFsXWsoG9vF97YigQKCwWgTujbcttgo/42B1UDzsGOL2lCHSgIQxGCr
         w6n+qlbf+i+3sin5CW0728s3i8Z/rlJ6FjZB02ds4AHvuF4yuXpuukgnRukqTdXKmLjZ
         0+Hp9fKmZzzIYIbdxLJnoUYhqT/nlhmkqu+pKRl040VGiyOcMma8+X9d1q5yiLb+MT1Z
         Bfku+n5I1oHrSGWhKI1hpYbKwxwChx9t8rhCRwHJOH9+kt8wrC0W8dV2pCN56GCDPliU
         PNJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=W+E2yob3VC1nC5T5vDlsuCeEoBLkoFNoqRZ0DeBs89U=;
        fh=kuzN2xdpOoi108lU+SzONpdT+LcxKOxpGTnQNCsIQJE=;
        b=V5b39VCBFC5IIyT682DsVr+idLEh2vxmUeeuDbOWa+01qA1+fpMktjYjr6qsTXSOtg
         JGMKV2DPpXN7OnN9+UMzbxP5kcE/5/7Q8OjW/1ljWSMPvr1ZsOawprVCaPxVXgJwB8HH
         LOTdlBzX2ZKRgziKIpt/MeXLjc17+Ox1bexvLK+BvYAr3gSqx58Ew12soL4uTK8mLb5g
         qeNNTU1s3SN5Vory6jN8d0oqmg8k9tsOdn3uvHsOe04G/2a844UjEW9TF8RQrbVKke+9
         E+iMvpJ8DdA7lq18Al8YskQYV75rn0Hd1ZtCFVInc9RuyP6TS1xu1sfNQQwzk1/6PYDL
         IArw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1787741521; x=1788346321; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=W+E2yob3VC1nC5T5vDlsuCeEoBLkoFNoqRZ0DeBs89U=;
        b=Yy4F1GcO/2WJXkbDkIeFkCEiyyq3oLKQfdoBqsvyox2X+Sdr0Ybisjs5uMexaYH3Z1
         8cfRav8nYhXP7DxhfBkI3n+ThUPvUlfORl62kh/YLRgJccYLVaHeqXbT1bAinJb1fRGc
         aTTTDW7LpUd/P9hZ5Rodvo4sVoK31EkyUNLw8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787741521; x=1788346321;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=W+E2yob3VC1nC5T5vDlsuCeEoBLkoFNoqRZ0DeBs89U=;
        b=XlYJ+PLQGD/M9JZewKybfGzxLR3OKD2qFR4VR6z8LqCalLZ6JrxxQlJZv1WGp/zpfH
         h1uk0H68LreoEUPoKSyBSUP9lAJfD1IA8V6pKT0qmbv6hpQ7xOeSQaUoNwFOdoFo4E3G
         h5IHS3Zs5L0qwbX0zWJ83qlK6dcMaNKlLi9to+Kt2MzftFK+oPszbTuHyGGDD7SX4iSN
         LV9KAj70yWkkNl+6sSueqJcMdXuPkZQSIW4bYcGVwR+oEE+x9qOVI28pTVpx3CHrdrGs
         7yTrAHaanFz1hnjXG4VCzwUrks2YefaHowoEK2p69c0Ww5HnV1Wp6Pfayeb+gbNmqnCF
         aKLg==
X-Forwarded-Encrypted: i=1; AHgh+Rp6dIUoP5aZKVeulft42/+hbvakBjlwbOXuHYdN2g3OOgu7T+Q2Hibv3u1bXJaQaT01NoOWo5JXrt4rwyFg@vger.kernel.org
X-Gm-Message-State: AFuF++m8Wsfi5/EL2TIIrgkRHa5+/rCSqJOdGWPrc7SM13YCbbK6rJWV
	i0iJZS//4jtNAFDiJJrWYudUHaeM/pvCJd2/5m+sBNgJORJJWlFqDgvOxu0bkrV2AXqR+iT5Twz
	9exSWzJ5rP7I8aU271lwXcTt2y94zlunUG9KQyG0hIA==
X-Gm-Gg: AR+sD11JDy7Bqb0cMjWvP5exeruss2TSu1oN8SbGocsHEUfxVnM7cygyBtqPKOawxcw
	7618sMFXphen3c3XYN25UnA8d0S613fDfKDPoRZ8wRjQfCEoTKxkwKOgAOIZqdC/9Hzdh38x0k/
	qN6J3DWTDcVEbZ8R5ZUcPT7hQe2CADtO8h5WAR6hJh9xC5Tb8bHtNUlCaeE+h/hn7fRVhD+o7rd
	9LzK245HOwSvyk0fvEKCQ+HcS7S4N1xno3fFG04BL7fgAQDuaHaBTKe6o6+LxGTm6GYeRDlH3TJ
	xRnTQc8BucJHFsCrR+2q+be9hY0Sn6URAYHXrso8IfuW32R6nEELIhYm5IUc7lAw5d1aN8j8Y7F
	a+G0=
X-Received: by 2002:a05:622a:1192:b0:52b:6543:d8a with SMTP id
 d75a77b69052e-52e423205a4mr50624011cf.26.1787741515931; Wed, 26 Aug 2026
 03:51:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260727210718.125872-1-psalian@google.com> <20260825175433.2588528-1-psalian@google.com>
In-Reply-To: <20260825175433.2588528-1-psalian@google.com>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Wed, 26 Aug 2026 12:51:44 +0200
X-Gm-Features: AcwNN1XetyIdhiAra5tdw_37A5FJQ5bKzyZQIMDhheeFgB1hN6l2gVmfLAojSAg
Message-ID: <CAJfpegsP62ZEddEY2Oh+SqOLngyztYkNEEK3W4rrvHRBXMFkyw@mail.gmail.com>
Subject: Re: [PATCH v2] fuse: mark DAX VMA page protections as decrypted
To: Punit Salian <psalian@google.com>
Cc: pankaj.gupta@amd.com, michael.roth@amd.com, thomas.lendacky@amd.com, 
	stefanha@redhat.com, vgoyal@redhat.com, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-coco@lists.linux.dev, x86@kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 25 Aug 2026 at 19:54, Punit Salian <psalian@google.com> wrote:

> Modify fuse_dax_mmap() to apply pgprot_decrypted() to vma->vm_page_prot
> when establishing FUSE DAX memory mappings. This ensures guest page
> table entries for shared DAX buffers are explicitly marked as decrypted,
> preventing memory encryption faults when accessing host-shared DAX memory.

Applied, thanks.

Miklos
