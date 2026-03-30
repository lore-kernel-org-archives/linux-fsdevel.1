Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CDC4363C77
	for <linux-fsdevel@vger.kernel.org>; Mon, 30 Mar 2026 15:43:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774885410; cv=pass; b=t3AanxJLWJ6T51fXMLIKFO+tXQDXaICM538HacaAw1CFlmiRDaSu7GXYen/cDM37JHmFQr9JiYn3LTmdMbiSUkME/ARcLPU2VVGH4xSDlu744Qhh15ONNHhs41X08KylW/hbxUonwxjg6qjIaOhFyM3hin+X43KcnjF3KFyGAow=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774885410; c=relaxed/simple;
	bh=t0esJnrDuRx8CALG5EiUG9NulCzrC+rzyK9Xog7c1xc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KdAL6s7iPy5Vbk9Uxpmgd38nujOuD5rYajCwqov+i5sNbf3sHsE+FeycHbbdi4HuG98yAVa9E7fX3ESfnk5kjDj3PRWoenSHLgvniUj7w6CWPUBAQtv+i1O+zQrNttbOC3w2R2TSUQRxmffsACIHzZvuIjuvgemaN1pzGse00LU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hS9bohJ+; arc=pass smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hS9bohJ+"
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-43cfd1f9fd1so822144f8f.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 30 Mar 2026 08:43:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774885408; cv=none;
        d=google.com; s=arc-20240605;
        b=fw5S8L2dWmKKGeQ55ar4PkLM52V+vEcY0R3htDPtHj2fyQ/NQTQPQEh9kkWCYr14R1
         PoGEUdxAlN/jXCHpEjxeXWWgYXDV3jsuEece+047jbjpVkS7ZQ2/IFWD2hxBCTNQllcr
         99Gf6OnIFfVXNWyYCzzeUtqVply9xY5YyB2Izlrp/g0xMjFHQoJ7RaSVHkztJxQlFfv6
         hZc02LABNqjZ00r1X3NRxgFeqBQKHDBQ6kg3/cDFtp9yawULS+T/6nNAOmttsvNOUd5B
         sINiZ7NdOON9sJ2NYtCPOk6vvVZf6T7S+VGVnf2nvaFIggbqnsPaYwfXy5jyNpfA/1gS
         WOXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=t0esJnrDuRx8CALG5EiUG9NulCzrC+rzyK9Xog7c1xc=;
        fh=KN/IEjQyChEi0eRt6bt8rV9HnrPH0bJoFzQXdJCnhM8=;
        b=dCDMBeb6pMcZoJGQxBTVCplmqLQSG/PTkF1yuNYeBOUKmJtJqJvxEOhriQ81OcG0Ai
         OP1gnmB5HE5CnvWBO27h+wDBTosTMEA82K88Hyg0N83b/VuV9IpUg9wC2o+NCirBxZiR
         iDmcgQI4cwbh6zZAe2T5DHmPyK4Ss2gzUxINGdAEwwPLGn2RSTJMI5572++Yml/fZq6h
         AOkv8uijmKgGHIQInZPPNlqsj9GMv0o4E7ctmxv1j8ecB44hZ1xqS49nYetCZ2ui8YrH
         9tJ+mRbKDQroK4DZn5q7mD3mZxcNZdjkFhglQmRR9I11W4aTAxiB3LxNrPfDOUgD9XWU
         GkZg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774885408; x=1775490208; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t0esJnrDuRx8CALG5EiUG9NulCzrC+rzyK9Xog7c1xc=;
        b=hS9bohJ+qKpZbSnF4/yedm32BCzgOgPglkEDhZT67xpAnbXa/5yQCFdKMkYcd/vYr3
         HEK78w0ek/2WzUHbBk4CW+ntf94D//EjxHy/KoWzKdCxPhE0sHC5r1yjTjEQrah1Kk+M
         oaagl/c2ubmg/MEd7e/l+gY31olq/wi3HN5GbWTS6CHdSc5nnAbUJmC9sTU4KDyZuGU5
         WX2CGlADnyjQ34r3ya7rqPEexj1CignSDvxlaKOtuxAeOC1EUS+/NnZTFHGcabUeQ4DU
         IgqQ9/3YgSd3mlfiGdt1DxT6sFDXtUN4iW4jpKDT++q6aipQs/xWM2kunW4FcYdUHPzy
         Tc8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774885408; x=1775490208;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=t0esJnrDuRx8CALG5EiUG9NulCzrC+rzyK9Xog7c1xc=;
        b=QojR2tsAItSnY9VLCiSzCq7i0djgAIGuU22R2EgfDs4UEwEAARCsipVo+/bSXSzw8M
         mATonWyzY5yUxi6SOXZLLqs99R2a9lLiWubBl05SFEBqta8XgAeh/flXmBgamXaM6253
         uRYNfPRklJzd3t3bfgCpmKuS4XSKZcg5Ei6ObWuvGxeums+tc9rLknWY9pn6O0ZSaOjj
         OsBrrMHbueZ97LzR+O5sXJ8fsnXuBTBb7wqTOn5pM27SuGY/qwo27e+wkkHTbsmw2DSg
         HAfRLz+nokSw9oAZllWWvdagbBgPjRIdcmAf1mOtwde+EG0ENeb51iRUGOR8+U0odf46
         XvQA==
X-Forwarded-Encrypted: i=1; AJvYcCVmUpqtCnfPcRW9QW13mCuysdg3Qzutb1296oS6iHNRVBvmo8wRVgegeQkgyjeCxXnQNhYkdsITscvfZMgk@vger.kernel.org
X-Gm-Message-State: AOJu0YwgUXhAniJOdX2bs5RV8FbXoI7imeSvDEnHpw5Im6c9udcTfqRW
	mFf7ku0J+BXE7Ni3ifNaSvSPbfcmHdfkuz7eawAo5wrtO9+s+hmI2IBi02Y/AgW2FEfa1j1xBHx
	1iLhtG4iK3SABFcJc7jzX5Fe/AY4pKH8=
X-Gm-Gg: ATEYQzw3S50Q1T2O30+CmmHnhh7BDBjCDuT2exsBJWdlxbshpZo/2bXTO3cQ3G3A6p4
	Ms8Xc4nyKZi0w2fpFA5s5TxWluHhZyAAKFkpET4ZvOGl0b5p+M+sxU9BZnbgBo3MV0zpszoNcDK
	jmA8whq4A7UqRj+rGu4AlZyrKS6LKh/eyDPCxrINs1yJXReETdsjEUY+S06Al2sD1WssJy3+0j8
	E0EwNeXKZbdw0mAbquZEnX/duDRH3PfkKCI20msvpydQkLTASeKD1CTVHZFFjJpz2EY9rxcj7H7
	CSgzznM+yHybyhfT
X-Received: by 2002:a5d:5f96:0:b0:439:ca9b:1f61 with SMTP id
 ffacd0b85a97d-43b9e9e8366mr21373296f8f.17.1774885407741; Mon, 30 Mar 2026
 08:43:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260324224532.3733468-9-joannelkoong@gmail.com> <202603281401.HP3uX5G1-lkp@intel.com>
In-Reply-To: <202603281401.HP3uX5G1-lkp@intel.com>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Mon, 30 Mar 2026 08:43:16 -0700
X-Gm-Features: AQROBzBlRnEc1XLiqyDMwQ1GSgp5676iHS2GTSkOtDm3v-siK_erACaW3pkAlq4
Message-ID: <CAJnrk1Z=yMy3FSt7wvCDgGCr-NQD4M=na2sAGsRM=KoTH2Nazw@mail.gmail.com>
Subject: Re: [PATCH v1 8/9] fuse: add zero-copy over io-uring
To: kernel test robot <lkp@intel.com>
Cc: axboe@kernel.dk, llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev, 
	miklos@szeredi.hu, bschubert@ddn.com, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Mar 28, 2026 at 6:54=E2=80=AFAM kernel test robot <lkp@intel.com> w=
rote:
>
> Hi Joanne,
>
> kernel test robot noticed the following build errors:
>
> [auto build test ERROR on mszeredi-fuse/for-next]
> [also build test ERROR on linus/master v7.0-rc5 next-20260327]
> [If your patch is applied to the wrong git tree, kindly drop us a note.

As noted in the cover letter, this series has a dependency on two
prior patchsets submitted to the io-uring tree. This series is for the
io-uring tree, not the fuse tree.

Thanks,
Joanne
