Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2194A3CAA52
	for <linux-fsdevel@vger.kernel.org>; Fri, 22 May 2026 10:33:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.180
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779446013; cv=pass; b=WqErqh5rWPmALNYiJjUV6WlDSDe1+E9++Pbe5XFzFqdoAtj4hGfx86/99sDbKzjlSZskfhwT5DmvP7U/9L+YWBDXYVylbiLLXEVkqBTqGr7b/LCvjwwjGWEbW0j1KrKJGqBvQ2/zRDZDko7ud/YOFNbj4GSS6/FgxC1q/kogyMU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779446013; c=relaxed/simple;
	bh=p/VdSGVbFrqiXAlT5Xg8uLbC62tLXxc2Jw0ObH3UOdY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iEVmii7nWrvmQ3JchsgrTkf1ucjiUrVNSUPpdm74VG8cZ+QW/4siAf9Yy0KDqurl0GJLMj5gdld8lmgJw5aAFnhfoi7b1FgWXPzZTATjLSQESlQAcXlGnLDI2E2r0M87sbiQhPrMsHSKDo+9i4KExLmetwReNFbMzkuX3+AYlVQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=iJGwgMHS; arc=pass smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="iJGwgMHS"
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-512f750d4b2so80756751cf.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 22 May 2026 03:33:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779446011; cv=none;
        d=google.com; s=arc-20240605;
        b=kH9tP4I3Ex6YIu4CxVuhS1KJW+B9xa0CgrscQ0gPUMHuzAhlflZleFoaTJUYGc97jq
         YAF1Vyg0NojclS1rzcwAU8O6OCxCTdOEEu9uWyvZ/88MSU4Q4GJvuEBURNjpnmp3SExc
         z+qDdCYIIEAs0SyVW9JEFHtmflLQ1kXV4jbI1E5ty/7gW7tGUCt5sCrot+WvpGIqNnrw
         UDnoCVYFR+jKqzDq/G5IzGdy39YELW0NMRgq5jU9N1tpj2d6h1naQeHuTsgHmaMCoYRT
         LM7fb5gveBdjXdxaBFQuMpgtkIVG+1Sh9SEyFLlqg9gW+3O+PZwAdOEcPdVfMTw3vrVp
         4SAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=z14oYsmaJGUy2giC8LHYGQR/U/5uLW2ju6hEqc58FVM=;
        fh=Li7TFldRScaf7c8HnzaNvAckI9eX5hs0w83Wjfwoyn4=;
        b=d/254yu9EXLJav/mo6X+ByPImYBwBpIBxDdiNb0ivfEHstqAQ9jskTg0mL40xS5lb0
         ToZIsILSkKBfbootUqf0j/WG4U7s5pMTxi84Ld4dEGHBbeml6YZC6fH9a9o0b/esMBcB
         To4eGw6oLG3FI4NxkS5McySC4trRC51jXDxqaIUlBbRuJqNEpck6uCF7zMbLL+14Oqrx
         nPwvwAwSmh4tnzDVjDWm8H56UmY+JwbRLbsM4LLFrjsNxvDlR52WHhcEQhF/8THBO8D5
         8w5dsHAlk7up0UMbbj5OhoQP9h9pLpmgwoiZwbAh58LGhOBtQJSRQli8WspkwsA+itGw
         rScw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1779446011; x=1780050811; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=z14oYsmaJGUy2giC8LHYGQR/U/5uLW2ju6hEqc58FVM=;
        b=iJGwgMHSgpNNEgFfUq0dnquBZaUOS+GLgGFZDi2zid77RefPOGzNGy3bw0EJiEH7rR
         NWUmVQDBuKrRBnPz/JbczRMUXmBP/rYJ8gxP3xlvN4PgFWxZX+pCUm23NA+TuQTq+POC
         eNlNNxRboK4otPE1UFM1PWIP5/k8Z4kUk6SfE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779446011; x=1780050811;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=z14oYsmaJGUy2giC8LHYGQR/U/5uLW2ju6hEqc58FVM=;
        b=kGk7dJe4wcDiSRkJ9hbO1v6JE0rvCHT0dEMLkpLNdDkP4Hr6He47XdIDXHdwh7saC2
         fu5bLnTnHVcJybcQw6ivwsWLrYNuhul0lOHS1XXcyZ+jU9To0DyffY/8DAu2SEvOY23K
         tYoDsOdigrZ6P7A+KGUTDBZGbk7V8qpzkB3JobjCulPS7XKW4Q+439UR48gngF9fABeD
         BeaYNHs6051f54psUk8dVIp5ItR2m/XjgHrJg7vaRXP1F4eOo3EeZNZpG9NR6hfMwdyH
         iP+bb4l4Txw8vhhPCS0TzP47/m/p6qYlirehrdrA9XO8CWIXxZrdUMDM4L2PQsdVkOta
         6JTg==
X-Gm-Message-State: AOJu0YzO/QAfAAw8ZLvgqZSgRCUI+/T7/MMKMSj7l8hq5OA0Mzumm7qa
	CaPZIF3+EYpKGgbXw7Oxy6UMdx8GcnZ9HWPbUSE9bNamAlUwhSvYBQTv/4jb7J1y6EPZgO5F4zD
	RKl0xGF5z9n52x3w5uCP+A3gBOq5vSK9wEqWXQEHMkWk1NmA18wyiTN8=
X-Gm-Gg: Acq92OGHYnU9wY+BPSvq7D4N0Hz81adIyvKzU++ZI8I+BNckEqg0bG2KkC1BzK1SC18
	by9ZvR2a9P8BQZE11BJoGuTZgiVdBg9Qobnd+WBtM53nR0C3QgknVawPHToTGJSCJm6stjlQuQq
	PenE02RokNaIcURYVULx75+X28AR6Tkdgk+xMWWSnPOEoclfWJfJrtnbn4oWOAeGDE4B3lcEfRO
	9hm5o2W3dw39+Ml4zLcPEAk0xpI/dIm9Yob6Z16YCWsbYWYJ4kJ+s1bIIyclCdvipMK4wqihhrg
	gCZRMhRN21WuJhPsu0/A1kmhneTMMZRyfdNYl2Y=
X-Received: by 2002:a05:622a:1a81:b0:516:3183:c1fc with SMTP id
 d75a77b69052e-516d43b30camr41920731cf.50.1779446011222; Fri, 22 May 2026
 03:33:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <177922944800.2436629.7011047808676668088.stgit@frogsfrogsfrogs> <177922944844.2436629.11205124993260163523.stgit@frogsfrogsfrogs>
In-Reply-To: <177922944844.2436629.11205124993260163523.stgit@frogsfrogsfrogs>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Fri, 22 May 2026 12:33:20 +0200
X-Gm-Features: AVHnY4L7xM_lm5a7sVX1WwSJTsMcU54KLYfEIl-hzIah71ML5fCtCjdZE6197HA
Message-ID: <CAJfpegtZ17FOj0QB2aJCiqt8Bx=CeA+i8Tvx1BhuPJFDVyUegQ@mail.gmail.com>
Subject: Re: [PATCH 1/4] fuse: move the passthrough-specific code back to passthrough.c
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, neal@gompa.dev, bernd@bsbernd.com, 
	joannelkoong@gmail.com, fuse-devel@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

On Wed, 20 May 2026 at 00:25, Darrick J. Wong <djwong@kernel.org> wrote:

> +#define FUSE_BACKING_TYPE_MASK         (0xFF)
> +#define FUSE_BACKING_TYPE_PASSTHROUGH  (0)
> +#define FUSE_BACKING_MAX_TYPE          (FUSE_BACKING_TYPE_PASSTHROUGH)
> +
> +#define FUSE_BACKING_FLAGS_ALL         (FUSE_BACKING_TYPE_MASK)
> +

Please drop the last two defines.  The _MAX and _ALL style
non-constants are essentially an automatic API breaker.  There's no
sane use for them, and insane ones WILL get broken when they change.

Thanks,
Miklos
