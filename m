Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.219.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793371574;
	b=d7wTfRqzOLbVIMjHSoNBZ7oAwRSrLOguED5nMKR+/MdKqqsHp4P0LgS/uqtSkK6thXwF
	 seLiBE1new6TonXSbo3oRyGIOPBJWtecJjVI1UfJRjUy9qKsL39myEUDhGO5wIaioAeX9
	 0hYreXVz1NnR8SfFhT3nSo3P45TzA3VsAg40GkFjnnW+IxBQw7MNUqHx8CR95HxPSiKjA
	 XdEeJNwmyTyQWnJXGrGNx5eCb0+X0mpmTRftH0+rmlVrlIxONlsxuPBtmATKZbluJ6ZSf
	 wxYXd1TI+b8V+/CqqSiriO/gpHHZ3FlPTOFxpQrEEcFid6rOQVbFD7vYMmkq1VNt+mw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793371574;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key;
	bh=yCMnnIVyw92jHKfgNzcCEWbI9184jZi+CFDafz0WrU0=;
	b=yrn4kcoTwcCuPKoJIot3rsTVAdKAvDkIQQ3tMQuLI815IxtbXQnIm6T7b9K7EX8WtI2F
	 q597CkwUo/nkVDwFvJoyhgCiPfOFLsc1h7N+w6e8onJgXXoatnzp4+D253eZJyjPknb0L
	 JnjZ2Cl0Cox98lJy6CT05HmAhRcVNIRezEE+xEwhHuEqjDJJ/Y7RKwb3rTX55Qdb/YASe
	 tjUS8fe1e8HrOs80dpIUekqLFUR5XOgFv/QbLXLICQzEFe257BBIDqLMqZiiCN+jo9N6I
	 27TFsJC+1SPQDIySeTWXA8P+Ozo2HypIhOIAOcyw5aBrR8NZYkh/349tf8pR9IglfBQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=toxicpanda.com;
	spf=pass smtp.mailfrom=toxicpanda.com;
	dkim=pass header.d=toxicpanda.com header.i=@toxicpanda.com header.a=rsa-sha256 header.s=google header.b=GUkp3W8c;
	arc=none smtp.remote-ip=209.85.219.50
Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCAA8606A322
	for <linux-fsdevel@vger.kernel.org>; Fri, 30 Oct 2026 14:46:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DCAA8606A322
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=toxicpanda.com header.i=@toxicpanda.com header.a=rsa-sha256 header.s=google header.b=GUkp3W8c
Received: by mail-qv1-f50.google.com with SMTP id 6a1803df08f44-91c75267b0fso8326176d6.3
        for <linux-fsdevel@vger.kernel.org>; Fri, 30 Oct 2026 07:46:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda.com; s=google; t=1793371573; x=1793976373; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=yCMnnIVyw92jHKfgNzcCEWbI9184jZi+CFDafz0WrU0=;
        b=GUkp3W8cdfD3QqeehBR/kAM+P8caGgRLjprvzReoLPSUyPEmU1dxodqd6nW+8G2arg
         kp1lbE7IyH20gSR/N5SZpzhRPCzsVaR54J9h03iNelKh73zijo5+AMepXC7oW2A0+ENB
         xtgyNDOSn+tnFz+j8fk7PqzJk7RSu4wfNM0MUkl8ndkrkHZyYkaHDsaYyM/02XPNE7Qs
         VgF/AAYJe/zena1CIhrDuXcwFbwRR5PL9LuNMYgXQS7IDYGCb6N59NrF7Jxd95LlSmMA
         JOmiYXn1lvRRD2yJmJJCsUxQip9XfKfaCoywXYQ9/TltqBawKOFQt9K3n3phcKRhlYbu
         tAuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793371573; x=1793976373;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=yCMnnIVyw92jHKfgNzcCEWbI9184jZi+CFDafz0WrU0=;
        b=D2NcaCnXIO8YQrkpFbHYvkbxNpKm7Yb9jye0fOqhogkGvGYBvrx85VpoPoGqoEhmDo
         oUzSW+W4IC78pe+UMBr/9X8431kA64bXtjFjxESg8z/jogK87snL0RVEAvu3R/aFU8TZ
         1ZzNPEUnQFp2k8TEK0I6ANZuW5sWLzoisl9GpryYzxynp5gob5wzVbOw06BVB7KNpu4p
         iNVL+l97Qe0gnfYXBieOqwrnJiNStx9YvC89P6Ocw8044mI8ixwN/DgnCgDD/6Ry9Vm4
         c6aZgxRYT6Fre06Pr82uRciZDd8veARcSHuWKDZUovCI7gENL05jSe5nrq28vFQL/kNc
         9fHA==
X-Forwarded-Encrypted: i=1; AKwUvBxSjM9DHwFBXlFaeysZ5dH2sIvuJ54kRlv/tvIck1e91K3FrBQACYJqPiTTSUTsp2FQQMvnbUIjnVX0vYGj@vger.kernel.org
X-Gm-Message-State: AFq9FYKNgvD725IsjZ3VAUSeuPOq4fHCGYA1ROmnAfaO83Tb2hGakYUC
	Cc8wD7IV6Kv5sUXvObPMTY3dRfPpvtedSdYsDsh30u8VpasndsUeni9XJS0HhycqSVkxOFvz3Xy
	hFHR+TAw=
X-Gm-Gg: AYBFou2wDunQ9J8uVm2W0JmYcIetl6PbGKnIu23QrEhSrk6HZC370YSwkG/fJlgvlq1
	5qiGUNcW96R57cFoGpdEmKAI9kvbMJ+0R6ATOB/OQyCPcA49p5tJGLYRG0gX+AOdST+TdB0XnP3
	vyRn7gkCeKhaUJ1Zvumqck1EY22uPOLoPBOzNFMIlO/gnulylhR/oMcP1QjpclOQD3/5u6yTxFC
	21Pj3OhurGisOX2lUKtdCe3QU+GwvUX9QzTWdZF5zW24KEVzOTv114QnCDKpvIO4JbS3UzegOFt
	dS4dQP3Ldb6Lh7KLHLfmklG2+brRnhG5pkoBnq5xmDhPQxE+Q6fGNDV9oXKSw78FCqWGEoMx3j/
	8zUwBFeVsrYK7tq7XuzvrQq2d6LZjEnA09R8BEsq1I1PIA1+NMkrB6dfQLvVEgg7Rn/FhwACkbd
	M2rN2IHV6XEmv082+SPOmiqA35tpIhYhTj36Am0vh5pKuEAm0986RrhX66iTHgjK76XYi0X90Hy
	OnoixDFoVvR0WLRqjY6EBXCdcqT0bGQvN1DTOHTBrVzjfpW9DkaxxZFhOEewfvWQ2w/pQeYRs/7
	sm9y68VHtLryjdr2+fB2tPzXR14la18ceJGry3X0VIgl
X-Received: by 2002:a05:6214:4507:b0:91c:7c3d:715b with SMTP id 6a1803df08f44-91ca4baa257mr36060366d6.55.1793371572909;
        Fri, 30 Oct 2026 07:46:12 -0700 (PDT)
Received: from toxicpanda.com ([153.61.196.253])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91ca807047bsm16670696d6.39.2026.10.30.07.46.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Oct 2026 07:46:12 -0700 (PDT)
From: Josef Bacik <josef@toxicpanda.com>
Subject: [PATCH 0/2] binfmt_elf: don't ignore a failed unmap while loading
 an image
Date: Fri, 30 Oct 2026 14:46:03 +0000
Message-Id: <20261030-b4-binfmt-elf-trim-v1-0-dbd8683bccf9@toxicpanda.com>
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAKyt5GoC/1WMQQ7CMAwEv1L5jEVaAge+gjjEiU2NaEBJipCq/
 p2EnjjOaHcWyJyUM5y7BRK/NeszVuh3HfjRxRujhsowmOHUm4NBskgaZSrID8GSdEIKQuYoHCw
 ZqMdXYtHPL3q5bpxnurMvrdQW5DIjJRf92BTZ/Wb+w7CuXxsq7/SgAAAA
X-Change-ID: 20261030-b4-binfmt-elf-trim-bdfb05fed4b0
To: Kees Cook <kees@kernel.org>
Cc: linux-mm@kvack.org, linux-fsdevel@vger.kernel.org, 
 Josef Bacik <josef@toxicpanda.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openssh-sha256; t=1793371570; l=1006;
 i=josef@toxicpanda.com; h=from:subject:message-id;
 bh=lg/mj6Jw3ZBjdLAYc6y3MhHuv172qISBdY785SlJBPE=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgUBr36M/n0nWN0DNbnxwzIiCZez6MG
 JiruuNaSCI/zXsAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QDzHcdXgLRvL7F9gDO3Le73SlD8R8UEbq0KX7qbr+KM1rRWzz9y1RBSZsofbVeEELhi1tAVcaTS
 liawpc9eNhgc=
X-Developer-Key: i=josef@toxicpanda.com; a=openssh;
 fpr=SHA256:C8kOX2QUJCMqnCX+KEeoqRAjLo9L+ELOSH2NSAJHqGA

Hello,

I went through everybody who ignores the return value of the munmap
family to see who can't cope with a VMA split failing, and the ELF
loader is the one that stood out.  elf_map() maps the whole image and
trims it down to the first segment, and if the trim fails we carry on
and run the image with its holes filled in.

The second patch is the same thing for the mapping we use to probe for
an aligned address for a static PIE.  That one doesn't need a split, I
only found it by reading.

I tested the first one with a loop that fails each allocation inside
execve() in turn and compares the layout of the new image.  Thanks,

Josef

---
Josef Bacik (2):
      binfmt_elf: fail the exec if the image can't be trimmed
      binfmt_elf: don't leave the alignment probe mapped

 fs/binfmt_elf.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)
---
base-commit: cd1d0b147afa81f80927f9711e53401703964217
change-id: 20261030-b4-binfmt-elf-trim-bdfb05fed4b0

