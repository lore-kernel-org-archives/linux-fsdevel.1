Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 468C62AE8D
	for <linux-fsdevel@vger.kernel.org>; Sat, 27 Jun 2026 04:16:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.179
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782533775; cv=pass; b=GPgwrk2xQtgMVR7V0wDiqhYd1MgAm7BlI372iLqWvQYs3ceD9FoKVJvjE5PQQtuMuSUoQw7DySJMPGblPPJxCz4EmkAJPqWR7Q3mTg4wQSEdKaDkuj5bAqtnFarXqxrbpUKzYtCPrKnLvwTR6xHgtZRZq3iGxrSWzjJnxyJycKw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782533775; c=relaxed/simple;
	bh=5Mez0UVq5CO0x6BED0BoGshO1ajy/0Ofb6wkewapMHY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sA8UhhUTBo5Gq8mW2Dt+ODYwNLf57j8ns/iPKZU0SfbN/KzNwufTxSbJlYK752bkxc1UGEch/0j80pL4icJx/0V97eUaoKKty9E+FpArqA10xdtaGj6Xk/2SCPV+5I3+VXHjqv/fEcMr2XllTanC3sAJJRucxyqmO4cIv1pTMU0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QrUAVb6+; arc=pass smtp.client-ip=209.85.128.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QrUAVb6+"
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-80c5cb9a888so8323167b3.3
        for <linux-fsdevel@vger.kernel.org>; Fri, 26 Jun 2026 21:16:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782533772; cv=none;
        d=google.com; s=arc-20260327;
        b=BoVvaJocbPj9Hi7gygwiacr1zbBFIuvcBBd3tctCSvwI5ieknX4jK5qohkbpZQznhU
         CS+G/imCg9P2wexZ3epRZ5Xn1nsf3T1gM6oE0G6hkUuphh0P1ZRc+uEVEQkt/QjvAcq1
         bgZ79fwphlUOU1lf03XCa25cy2DjAtwF41Pyl4oj4P4NwuX+zVbP8zzXIJvMw0rna305
         8dnoiFPpfWp2gc2iL58auat4J5TTtjJScXqThNUPUOVPdk6DVIg1O/3QGcC5UEyUPoo9
         EOIdA9X75ec00d/RKry0yex6/xRL9wRIkoFwlboNmzoOziOAOxG0i7Bdv8K1L1/sEe+o
         Tz4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=GiWBxpTAMMjeP2jJR1lAQsVtIodBGUmEtyeANjybxxQ=;
        fh=K62k7G6ZSBeKF2JPdr3lTdpBcIH4+xpdRdGedp6d5vg=;
        b=jT/RlLy+UpJwgUWP1GY5IMIf4RZuHnxmPXDi0sasjL/Kv9vccEMRbgXPkua4kKNKEs
         r0qrCnGlwWQovV0bWJYFVvNAa/UxX/vJYj6KzUfw5D1QFko9g6RrXsYe7IpGB4/5NP8m
         Cin0Jg6VMP4k+dgRllG4gPQ5kF7h61N33h1cxXgjQoqnaj6PjCApJF/ty5/SyY7/SnKE
         NC/nGZGxGLcTewN9FQmYyfhREy5ace4zHVt2VyJx4FGDW073YlcIzxAhsb57WbEY/5Uy
         AA4wm5QJF5WghBJKbgEOVHU5pKskDw1/KrQTMEeVse/eIHptymu7u23SDEHfwIi/BK6p
         CMPg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782533772; x=1783138572; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=GiWBxpTAMMjeP2jJR1lAQsVtIodBGUmEtyeANjybxxQ=;
        b=QrUAVb6+TchLFBY77XaYDSEstSXKK48M7+DmkUFi1VnthhShOvZaS5dvU+egDhXTfp
         nWGf4Cl27yHlhVwNnixXQixHlDnoEt1sVhegsyd4i7NrxIGKoivboWDkxYnVkdGpvet6
         wQA7M1HlTDYfxJJEsvM7dBqA66q5E8qvWsz4xHqqQM5JMSK+ZiuZtmnp66MXhOoVNcFi
         gRFMieFb2lUkERW7VmBwaoo+as4TXFK0QPLWVl+owgj5iEIW7gArJ496gJlDRDjSFwD5
         hX2dGGNYDQPJt0k4E/FA0qTG2whZCw6SIhcOIP5h3jAmiS8wGUX9Dmxverj28XsnPq/E
         pNfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782533772; x=1783138572;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GiWBxpTAMMjeP2jJR1lAQsVtIodBGUmEtyeANjybxxQ=;
        b=WBZH61TKnsWa+YEgWyLNtE5fsxx2A1P64HUDtP/BSu7xx9Bj3gSws/6rmzZnqjH1vY
         2EJUgZrjnC6rJ+iPRRCV2rHVtTtC+Ok7DpivUVcYmg6kkRF9Cq9l7nOytadaXBy0iyN3
         STG7k8QxG2mW6IBhM/t9lRkUXM6pqiFXJFQe9AV03DlLD4ZIkVQ1awBILJXU8ZYLKhX+
         l9LIyNkC3h1eq7k9lTWN1E3rdpA4fe0jBS+/zHnSn2jw6aTIpE/r3o9e2Lmf4D+PfChu
         JBJbdX/vIa10Lb+FmllDMv1BcZ9Rm/ab4ofXF3JXoCmcmaS4KjKKdMYg9nU4WMkXGlCP
         jT8Q==
X-Forwarded-Encrypted: i=1; AHgh+RoYYexoLKdDM0VtyMBniDie2VdHPd9oJdRFimMAwt4T5N8O9gUrMataYg6HZ2+63MyMcVbC/3tlZRBU97/J@vger.kernel.org
X-Gm-Message-State: AOJu0YxVXIdJj4FJ1nIgDyU7N1yGawOkS5NHacANYkPMMZQ3sLlPN1tJ
	4sBwZYuLcsajw/oAiXvml192ezwkpe5CRuDuvcya20shroAqLpYC1FGUKHbQhj596wa7uGORF2X
	28QH6yhal8gRiqhgSbZf1MKust3GjusA=
X-Gm-Gg: AfdE7cmNK4t2AH5Fgh/vX5+BVYisG5Ogu69UJ+JJj0CzaJgn+r54sylKsbvtlap7Mmu
	4x4GCCzmpIKnVjfEkwLkR/K77KZ4bUMJQE/Sahpf8y23cPUf0FHdceMhAhFwXTz110/jxWQOdF9
	HLulAYxcji03KIXvaaENL1s+0/SigKmY0J0elI02bonl7teOWXHBs6pUQEwoU3bpAmx3VClJQL+
	mOzB4J2zw6PigEqDMBHWfxLWu/jIH2fb3SzL+Spio05ESbj6/2E9DqkJpaol5K699NJ2Ltgp00=
X-Received: by 2002:a05:690c:e202:10b0:80b:968:29ff with SMTP id
 00721157ae682-80b09685e6fmr58526517b3.53.1782533772302; Fri, 26 Jun 2026
 21:16:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260625083353.132243-1-zzzccc427@gmail.com> <CANFS6baqSnmOYSAWF28sozgoGhyY-9zCDHy9ppmoOCr9POeuaQ@mail.gmail.com>
In-Reply-To: <CANFS6baqSnmOYSAWF28sozgoGhyY-9zCDHy9ppmoOCr9POeuaQ@mail.gmail.com>
From: Cen Zhang <zzzccc427@gmail.com>
Date: Sat, 27 Jun 2026 12:16:00 +0800
X-Gm-Features: AVVi8Ce0UiT1CB4tL1Q5hxEdpGUFpzmUqKpiCTweuabRqdEwZY-crP_Khb4JuyY
Message-ID: <CAFRLqsUF1ZRm9L8HjhNC86WD6PMbWeNH-quE1AizK7KJXrkh3w@mail.gmail.com>
Subject: Re: [PATCH] ntfs: avoid stale runlist element dereference in fallocate
To: Hyunchul Lee <hyc.lee@gmail.com>
Cc: Namjae Jeon <linkinjeon@kernel.org>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, baijiaju1990@gmail.com
Content-Type: text/plain; charset="UTF-8"

Hi Hyunchul,

>
> Looks good to me.
>
> Reviewed-by: Hyunchul Lee <hyc.lee@gmail.com>
>
> Additionally, we need to skip ntfs_dio_zero_range() if
> clusters are not allocated.
>
> @@ -5647,9 +5647,10 @@ int ntfs_attr_fallocate(struct ntfs_inode *ni,
> loff_t start, loff_t byte_len, bo
>                                 if (err)
>                                         goto out;
>
> -                               err = ntfs_dio_zero_range(VFS_I(ni),
> -                                                         lcn <<
> vol->cluster_size_bits,
> -                                                         alloc_cnt <<
> vol->cluster_size_bits);
> +                               if (balloc)
> +                                       err = ntfs_dio_zero_range(VFS_I(ni),
> +                                                                 lcn
> << vol->cluster_size_bits,
> +
> alloc_cnt << vol->cluster_size_bits);
>

Thanks for your review. I will fold that into v2 and I will keep your
Reviewed-by unless you prefer otherwise.

Best Regards,
Cen Zhang
