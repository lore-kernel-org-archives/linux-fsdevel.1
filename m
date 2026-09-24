Received: from mail-pj2-f12.google.com (mail-pj2-f12.google.com [74.125.227.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCC0B3DCD8A
	for <linux-fsdevel@vger.kernel.org>; Thu, 24 Sep 2026 04:32:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790224321; cv=none; b=TijoKMJPLO121jwJ2Wiqi23WsOepIpIGudOeY3VpRapLuDpcjZNKJFy/Y4oPD7dBJWoTGpyX74Oi3phauAnvQRa6GFp+L7eSJpWMWoTjAjD6NtnsgbvDVQEtcSuuCfLWB+pFqAgOsd87J8fFUklfze1uOUlZRk12DBfTAB6yDWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790224321; c=relaxed/simple;
	bh=3JAG6Ij9c36PXq4bgsIh1K7CQfbf0z/ay7gB5qrwte4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TOb9J1KihL7mlf6ZZ86Qy6ckrin7AjBgc7VSX3pFtMyJR2mOR/SXFzsku+ogDB63Qgte0eWvn2GGuOlNjEDdgy5ufLnvNqjsS9lpyLOJc9u2r1emx8JnOANgjSPOUeo6GU08KstP54lagm6LnGYWXzpW/eU8wavkvk6swdbZ030=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Qn9nur6F; arc=none smtp.client-ip=74.125.227.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Qn9nur6F"
Received: by mail-pj2-f12.google.com with SMTP id 98e67ed59e1d1-396ccd78e6eso658492a91.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 23 Sep 2026 21:32:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790224320; x=1790829120; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=3JAG6Ij9c36PXq4bgsIh1K7CQfbf0z/ay7gB5qrwte4=;
        b=Qn9nur6F8AFN2P6ahcZ/4fYYZtVG77XTje1XnUUKFFtj5e3DzByEgv3B5GptoLuQYI
         4GPvf3Wq9LPdNcO2k7l/aeJ2egnX0zbfHvRtjXEd2Y9v48vEyhI4+vljychf6VOTMoMX
         /g9CGDmARwzCMN/2eaMdYaORMN/9N/ddcSlL1QamxGsuwGQRD4WfNHPMz+IIZGl5yRE2
         HM8Rtc23z+QJ8ztjCbo2GooCA5lNwLOixfSP8RzppHaSWFLJ45qAIRJDRupn/g+9h3HI
         GX3PqacrdgpkvUFO0LWIx3GwvxhFlbkfLVn6j5VL8aFUGZUaH6en/XeF1UGl/hLIKCsy
         954Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790224320; x=1790829120;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=3JAG6Ij9c36PXq4bgsIh1K7CQfbf0z/ay7gB5qrwte4=;
        b=Z2CYRyhz2DT8uzFsbNYm5Bs+ZXpn4DabQlR+BdOhN++C0aLa7N8jIUkhazf/pbiW5c
         9BVmFqcv3GuT94PaAeL9+z+tcLkGipFJzfkBKzmSWTRlAxHgxmPm66NfVUVpX3QzacPa
         EcnXDHIKkFH5+QLZ+y7XoWeuZ4iORiYmtgADnHmmrGkDfm53gKin0oc6tq6u8Aqp9gDO
         Sy8RhMz93VO5rROPrBEmcxXdj0Ad6Y1MAcan/czOw2QzHN0HPWNVgPtyKPDfSv0arOkJ
         KuV8AFuTlziBQaOPxyYYzi0l/ZOVhwoss+wE9aTeHsrwVA8uW4T6euEf+LdAhg0uFwht
         AR6w==
X-Forwarded-Encrypted: i=1; AKwUvBzHr2QndjlB9qxCZ01XQBaPdLKWnkJ2DVcnFN+Fl2N3c1isfIuDUXkXBCJ3KK/Hpi2lG339zay9ZiBJRgL+@vger.kernel.org
X-Gm-Message-State: AFuF++leTrjJlEyvkA6Y76HtpIc9VVzI2R9AaQ2ypkyA0Ktn8Zzo3y/o
	I1qlx14sjQYE/EXjcUhDtKl2UQ0014VoFf0GIRj9emVnXvDW3rNjsKf3
X-Gm-Gg: AYBFou1QtaEpuXRzyNokCjH6IayLAthH+OZ57tgEPU1z9wvqkpJ6YEgEdQsE/slDYUm
	1MacVE6lb8ZnYZwFg8GzqtwaYYlImE3NZBd3y/FcPw3tsvLjcqnKkJ1OrJfC8GsVayfU0U/ld1T
	Py2nHiwMilus6PG5pYZ/MBhbENy5ecgccXkksPDbLUiYedU+9Lfv8b6bk+CkUed0zh/E4o59CUi
	NN4E+8Gq44Q4UuF+mGhCVl7IUeFvPxM27knV5st7XkhRsw/uCgdWwHF2fPKmH589R0jOPJ0E+8v
	1gtPalLz3kdjq5sNASAjEhnyaM/sOWHdjb4vz401WKJcl+fSvAUVmt+xWGzlE5kPsHzyeuUxMwj
	O4y3nscc05XzNoX+xznqNKyaSpGAGRfnRXkqUWpRCF13rOY4dRplWscRRKvlWpnuibWxkLZabhM
	HnGMS8oCSNarebei0mIHI2FfTHctmNcFiHXL+yEcRctYBPqzlpmA4oAowH0vjJAIQcKqx4e2Pkn
	dZ+oOOMeo4wJvqVnLvyieFHHroVDfVdtJuoHVX678q5PbugiwmTt88hcJ8YCs2PeiZzSxfNmf8C
	Rfm9HHhlIoa95xAfsmzNfnGgy36I9MNyHtciGe7SKBRY/tXwoz5OMv9J+1g=
X-Received: by 2002:a17:90a:f94f:b0:3a0:2614:2077 with SMTP id 98e67ed59e1d1-3a098b93d4bmr850160a91.41.1790224319843;
        Wed, 23 Sep 2026 21:31:59 -0700 (PDT)
Received: from spider.bream-herring.ts.net ([103.6.151.236])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a092d9797bsm1496938a91.1.2026.09.23.21.31.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Sep 2026 21:31:59 -0700 (PDT)
From: Matthias Goergens <matthias.goergens@gmail.com>
To: Hui Peng <benquike@gmail.com>
Cc: Damien Le Moal <dlemoal@kernel.org>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	Jeff Layton <jlayton@kernel.org>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v2 6/6] qnx6: validate sb_blocksize before dividing in qnx6_mmi_fill_super()
Date: Thu, 24 Sep 2026 12:31:55 +0800
Message-ID: <20260924043155.3898135-1-matthias.goergens@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260921042511.1473629-6-benquike@gmail.com>
References: <20260919222556.3792829-1-benquike@gmail.com> <f68323da-e90f-46a4-b3ce-70d26de115e6@kernel.org> <20260921042511.1473629-1-benquike@gmail.com> <20260921042511.1473629-6-benquike@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Tested as described in my reply to 1/6.

Tested-by: Matthias Goergens <matthias.goergens@gmail.com>
Reviewed-by: Matthias Goergens <matthias.goergens@gmail.com>
