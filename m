Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 937E634A78F
	for <linux-fsdevel@vger.kernel.org>; Sat, 25 Apr 2026 15:42:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777131765; cv=none; b=ufItC5+qAK9i0TS8XWJqE6wbMKAljBN4jKVEPjMFjLeiQkkyn6P4Xm1wwf7a+RjQV8+jV6zrxIorCWejfCNWl2VtUCLfLwKoVoQASm1WXV9nNNEsbCDUmycRgQUhUlklRqRNOKmvVwXiTDNQvmjLrJQjjx4Eipl8ThJ1/aEUn80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777131765; c=relaxed/simple;
	bh=KFRIfgmfjM3VnoIPT44Ls619E4DdFbrGJYuXzFbTFH4=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=UBGirppimHbl+iq/60RVsfYZILgrxb3NY6sSmhaCNOuOs8/0i7Teej7x/kAe08Rq3Ou4WiPmM5S+/lncZzrr+SHbp6ItESrjW+rA9sFSJqX2V2wcfgC2PK+yjGrDA1OODXNX3ls78d+FLqzvhZ8rnckUDYhm9xV/E8ULXfrW4Ag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lejyJzF3; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lejyJzF3"
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-5a3d1561e38so7318734e87.0
        for <linux-fsdevel@vger.kernel.org>; Sat, 25 Apr 2026 08:42:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777131763; x=1777736563; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=s1Pji+xPwcKNy5aZW1etp5CSTGlupxM5tsrDxbvS93U=;
        b=lejyJzF3YscDXdSZttm/UD+QIgdFKY+QFnytWUAtrX1Q90F91b1xK8kzE4HXFREFRt
         6Ly3KzR8KoQ3rukPKkTnxJafIr3qPWKun/dZqzQeFWpkqxFG72njuNs9DkesyloKCWff
         gBHDxuNwWrZXI2soo+fq7tIqMQt8qHluKCT4LZFWO1L9xCHJt65Vm0drWR9E2KlR9B5x
         Aflw1FI39MjVTzadhuPzpTXwUu9R0clhD9mI/HrpAk6LVva+wjpZ9NSx9o32yJimSAzk
         Dh6kRExx4hbWQ2t3r9D+le8E7wJa4g61ff0B7op2nzdxwFtrLEYfMkkrOit1+5wcXF8m
         3hOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777131763; x=1777736563;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=s1Pji+xPwcKNy5aZW1etp5CSTGlupxM5tsrDxbvS93U=;
        b=h6t1xD4El2a3V9U8CHxIdstdTmeAFEFDE5Y6WoVpO4+5oOUqh/FIBOArRvqSCRKjCh
         mNcObIsQCs8ZpUVmAkWBHnLPXqZuThunr+h9p9A2d5lv12uT4H7y92hJV94iO3hr4Txa
         NLFWEAn8gM4nlyRqYRgT6J2WbsKqZhyBIbg/UGX03rlRphlrTPwAshw2JsgriF22Y2Pz
         YsjcDuXO6aZ8KGafDkcH9CZMRZVgBoZAwEf0/IoBCXA9ggDfxDC/tfCRlI4fV6+PtJyC
         iBhYa7ZxdC3fgiKsBNZ4vTcgnRysBWwo2ULIvR89hN8MUSculVTz2oD2KkgTCJ8jzqdJ
         qI/A==
X-Gm-Message-State: AOJu0YwkpCZIxFI3TELxNoBsfqIMnzyBSSGXFVxrS2lEB2WW46eFYIjy
	n5S52LfvNtoR5gYvadcFSzbO3bfkIDUBlDMuo7BsJvJMOOnhck3HmgVSofeL
X-Gm-Gg: AeBDievOQWgANCV5fECjXBoUsmIqC8EjvnVtsLAZAbpY1rXcVWDixFF5bJyc79C8tmE
	XDoAjrT1IePLmVa96OW179RLMKYhvHz1hIFwNYorJy++h89A88FZly9rskXE3E7g5x6i+AKurdO
	cLckxowf5aIwL5mvq5ZfmWm0pqbQtun6ih2LTUlH6rF3UIshwJ6HoHXSjS22WIRxlxFHDakCxd/
	vpIUsGwNPgnun3vc+332JE48kvfF0iPW5x6ALrJQ+eZcuUUNQmbZsu7tq0WappOZFbZ1y18djSP
	Wbgnilv+Q0kP6sJnHTSw5fwcGvlUdnYny03EWopXCOFCfouZ8Jie0tU9gXc51pPsOcz+krYMScB
	DDjAQHcHdBSt/IJKHWnZQdTYAmshTqCP4vuI0IGASYVxpeUe5TCj1+IDiUzX937UpHm11ZTDS0g
	ypwRbYIfybHt+MtDF3UKjGtW8=
X-Received: by 2002:a05:6512:3f15:b0:5a2:798e:7dc5 with SMTP id 2adb3069b0e04-5a41730a254mr11733584e87.44.1777131762521;
        Sat, 25 Apr 2026 08:42:42 -0700 (PDT)
Received: from p183 ([178.172.147.163])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5a63296adb0sm2322023e87.6.2026.04.25.08.42.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Apr 2026 08:42:42 -0700 (PDT)
Date: Sat, 25 Apr 2026 18:44:53 +0300
From: Alexey Dobriyan <adobriyan@gmail.com>
To: Damien Le Moal <dlemoal@kernel.org>,
	Naohiro Aota <naohiro.aota@wdc.com>,
	Johannes Thumshirn <jth@kernel.org>
Cc: linux-fsdevel@vger.kernel.org
Subject: integer parsing overflow in zonefs_fname_to_fno()
Message-ID: <a16c4a17-cb72-4e5d-bf8a-7c6ad5482128@p183>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

zonefs_fname_to_fno() does

	fno += (c - '0') * shift;
	shift *= 10;

which is obviously broken because integer overflow and string,
coming from userspace, can't be trusted.

Also, zonefs_lookup() could use is_root_inode() helper.
