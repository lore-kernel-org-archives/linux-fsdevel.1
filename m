Received: from mxout5.mail.janestreet.com (mxout5.mail.janestreet.com [64.215.233.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAC453D45FA
	for <linux-fsdevel@vger.kernel.org>; Mon,  8 Jun 2026 17:17:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=64.215.233.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780939049; cv=fail; b=fVRGLHfz0yp3ycagShu4YLdn8afPPfKGnzkZv5D/zsXUSiD58C7H1YobzOLLQOQS4H88rKaaaEWsc/woH2EpqIxTLGewJFCGATa7J7rQObni35dG2V8kzJ0e2QhzHrN87v18dI5TCcpFFuS2rslcLVgmkOwlnbDEV6/dqqiOQYU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780939049; c=relaxed/simple;
	bh=nviWi2SVvs6kP8+AcZcCp02bcOI3+H6tiI/C6wy+oDU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=O/9vA/zXTGihIJdfOvo7JiJFYWeU/w5SA2mfesijg+1ebBvOYjl9n14Zmb5ZCTSqak81qHPtZEb2xV+82vjgJpwwVVSl+Zubw0ny+I+tzBqOiEKb06L7m9ZmLNXVwslK0rGus8rA8TeVbbyzN+sq2AvvFVKkbrhWl/SpRXSRJwc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=janestreet.com; spf=pass smtp.mailfrom=janestreet.com; dkim=pass (1024-bit key) header.d=janestreet.com header.i=@janestreet.com header.b=XXcB22Lt; dkim=pass (2048-bit key) header.d=janestreet.com header.i=@janestreet.com header.b=iEF9RcsS; arc=fail smtp.client-ip=64.215.233.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=janestreet.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=janestreet.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=janestreet.com header.i=@janestreet.com header.b="XXcB22Lt";
	dkim=pass (2048-bit key) header.d=janestreet.com header.i=@janestreet.com header.b="iEF9RcsS"
Received: from mail-ej1-f71.google.com ([209.85.218.71])
 	by mxgoog2.mail.janestreet.com with esmtps (TLS1.3:TLS_AES_128_GCM_SHA256:128)
 	(Exim 4.99.4)
 	id 1wWdbG-00000006QtU-2vFB
 	for linux-fsdevel@vger.kernel.org;
 	Mon, 08 Jun 2026 13:17:22 -0400
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-bebbba3c343so199066866b.0
         for <linux-fsdevel@vger.kernel.org>; Mon, 08 Jun 2026 10:17:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780939042; cv=none;
         d=google.com; s=arc-20240605;
         b=UiCeq378EhM//xUgJ+EOJNZcB0HPzEjrCODFV/RoI5vnjWJGg6l8SG8T+6IqRgenfW
          HyOvW5vMY2jtcFi49yoJSpmjLvtjepQw/j6DHYQwS0GFxdsDkhmYryRVwroQQy4BYDVZ
          Jodd9G4MFNNgiS2hk36h+q/omAKdmAYyPXv0YlbXCXv8yB0F394z0GgG8YSKHQYCs21M
          IYP4OSn4kiryOCbzzFSuuWWSo8wXz5kLL2CPqkf1ZAilZcbkurAYtIIUgbPYz+jteCQp
          7VKA+1mQGZ44P22t5vZF6hcJtQq4q9o2HTBaxBl4vM8AmZxmsONOs698ae19T+qsqDMn
          FhsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
         h=content-transfer-encoding:cc:to:subject:message-id:date:from
          :in-reply-to:references:mime-version:dkim-signature;
         bh=nviWi2SVvs6kP8+AcZcCp02bcOI3+H6tiI/C6wy+oDU=;
         fh=p2xVL/1IchDJ4L7drZfAvTNxFP62b3UAh5+jZdtJ2Uc=;
         b=HPk2bsOX5licjlNJkcvohzDxmH1atCJF6/qrFtBYsCEcZzOIsMsmgnPIrzF8hLmq4h
          S+IzOfyB8gkVP3ap8dZuC8yEcFgDzpbsI7c5NCpLA/CnpweL7cSLQ0a6WcKQqtgHzTsR
          YKcLf0RH4bBAfFENyWo2ac8l9ekimx4oyk/SH/HfVvOUqaC7FtMC4XBL9gEIv7KHxiEZ
          VoJffgUocRF3pzkhT/xn4f5/PcAjepHO7tTk3WzoL/OyXau0OxmUONZaBIv2dzXd635P
          lMdtYGwKhHuHT9mJUfwW2u5QB6wrEoOjR1qLLsDblLdKAz7SZumeEoLIwIX00e3NKPT6
          Iv8Q==;
         darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
         d=janestreet.com; s=google; t=1780939042; x=1781543842; darn=vger.kernel.org;
         h=content-transfer-encoding:cc:to:subject:message-id:date:from
          :in-reply-to:references:mime-version:from:to:cc:subject:date
          :message-id:reply-to;
         bh=nviWi2SVvs6kP8+AcZcCp02bcOI3+H6tiI/C6wy+oDU=;
         b=XXcB22LtEBzsh1FnSTtwXA4PQX97VVdzgkwsMoenOMe8iiJeoX4Tz9ZqARwvw3ExsE
          x22P18IubQK8L+O6WHC/36u+ayUgmmPluBmeFKmwrwDQE0TPVbMEe+TiHpfANPJTKgSG
          nJT78VuOl+/Ahv4bNHmatz+RdxhySgBInpZwM=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=janestreet.com;
  s=waixah; t=1780939042;
  bh=nviWi2SVvs6kP8+AcZcCp02bcOI3+H6tiI/C6wy+oDU=;
  h=References:In-Reply-To:From:Date:Subject:To:Cc;
  b=iEF9RcsSVUznVNnTsCCypCI0GGTTr0aqGDIQelANpcqz1YD1dMTzOqyHe8Tc/1SZb
  uuVnGMN6wLAIQAifDYRR7vKISMCtL56XmY+8Zy3q15ursCo+qXSD4WIrn4z2pht1+2
  keSAGpV1H2z7C5233YiaePDrJ0DGUA16NZrlPj8KqQjcjyaCpwVzzSCVkgrR0Qh8qG
  AMzCv0vJ8sBkzyRjAl/1xt1d4XKoyYF5AqISfRz7ma2kkHezI/bOYZs3hSgGCfDoba
  6Bip2Kvp2DZOfFhylOnHdSQ+V8eHfwCpy55DFOe51Ci6aAlghHh6ANWQtX/WiST9vK
  +z3enW0HS6dqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
         d=1e100.net; s=20251104; t=1780939042; x=1781543842;
         h=content-transfer-encoding:cc:to:subject:message-id:date:from
          :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
          :to:cc:subject:date:message-id:reply-to;
         bh=nviWi2SVvs6kP8+AcZcCp02bcOI3+H6tiI/C6wy+oDU=;
         b=P4sYN1fNC0DywjdHNbLyfooLfTB/FQkYAg0XaSbsmY1OPE9bWJfL+CMx2WTriLFb/D
          AT/orfMnV8pjR3LpNSD902fEt53tnXsqfwAO8gConshmzWH75HzBI4tIdjJPDYNvoJf4
          MYFQ6qZzj6qZ0VVXQ4goTAQjAcgL22H/8mQG0QgzIabOd+7I9RFnHCMcHaKeNaFaOk51
          q3RMUG1j/3BW28NDdrIo5yDG8GTxNnpHpgiRs+zElFdpMtTnW7gnZtRUlk4zsmzr5o9/
          eEDW8jPtpK4JRxlikhtK1BdRZiChtfD3p5O1fel9Ysq/hdcFUUn+teNlKyyzCh8lqIWM
          5iVg==
X-Forwarded-Encrypted: i=1; AFNElJ/rwmf+jWMBQwGhT40zlsNcjt86xMZN61n8Itjg4n6V/v/tTpfuJ2hzDST8UPPnvpnP/V+b1ZqtUL/Emn1O@vger.kernel.org
X-Gm-Message-State: AOJu0YwuL7zQxMdILFGaegxgyUO3w93VG4WSQ7dfMXTFupoc6UOJwOa8
 	uSMvVA3M4QIO9zHbVkwI7B3HRhYzPStb8vMPtaELDUaJf1uD0DIC5tg3deRsg7hkDpmHtAkR8zk
 	uC+TjENeXjusPyR7l7MpMh3j+bRY5NJme2OnknD6dZZn8GtIwhK/DLRShG1MlP12B02QA+LRl/5
 	EPLeU8IVbGNeOUsgtT7GjzhZAKnYHO+5brZvIaOQoB
X-Gm-Gg: Acq92OGm70oTpA1aGS/ZGMvB5i2r8kQkMrbb3fYi2jLy04ito5pBoIhaX0/8dSknsAb
 	uesFPQc8F6Uuoag82vFNNdKrqAjTPdqIb6SWzECZpbBRHPp0vQoB6QvqupJtxoeDXKFCiXp/VWf
 	9cqGRsmN7r83cOWmcyDIBWC74DctA8uUmn11slQhq8u3Rz4kE75nXLPEYM5B0KTr5PgHog/xOas
 	o+Nxbh63cSOGPcF
X-Received: by 2002:a17:907:6d05:b0:bed:afd7:185 with SMTP id a640c23a62f3a-bf3737ed359mr795417266b.43.1780939041653;
         Mon, 08 Jun 2026 10:17:21 -0700 (PDT)
X-Received: by 2002:a17:907:6d05:b0:bed:afd7:185 with SMTP id
  a640c23a62f3a-bf3737ed359mr795415166b.43.1780939041283; Mon, 08 Jun 2026
  10:17:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAFN_u7FrgM4Dzie2jjkLwWV8P0dvUG_Wwy3Q9B3-2HnnWiDu8w@mail.gmail.com>
  <aiLxe-9Sub8cI3Py@bfoster> <aibns0xP6IVVNWh3@bfoster>
In-Reply-To: <aibns0xP6IVVNWh3@bfoster>
From: Eric Hagberg <ehagberg@janestreet.com>
Date: Mon, 8 Jun 2026 13:17:10 -0400
X-Gm-Features: AVVi8CcZJIKOxJFnY3us1cFaahXNeQdHGkpT9n3Gwe9O5wCWWT-jbuC6519peWk
Message-ID: <CAAH4uRB+Bh9UEVEW8Sb2yM4YhB-Q5UJ6KJJXari3DDF3n3S+-g@mail.gmail.com>
Subject: Re: [BUG] iomap/io_uring: O_APPEND async buffered write silently
  re-appends a data chunk (corruption) on XFS, 6.1.y/6.12.y
To: Brian Foster <bfoster@redhat.com>
Cc: Gregg Leventhal <gleventhal@janestreet.com>, hch@infradead.org, djwong@kernel.org, 
 	linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
 	io-uring@vger.kernel.org, Jens Axboe <axboe@kernel.dk>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 8, 2026 at 12:03=E2=80=AFPM Brian Foster <bfoster@redhat.com> w=
rote:
> Another idea that came to mind is to try and just replace the -EAGAIN
> return sequence from the low level iterator with a flag that triggers
> -EAGAIN from the next iter advance. The idea here is to allow the write
> to return partial completion (i.e. so no iov_iter revert) without having
> to return an error from the lowest level in the stack. I had claude come
> up with a quick patch [1] for reference/experimentation.
>
> This is based on v6.12 stable and compile tested only. It needs more
> review and testing in general but might be worth throwing your
> reproducer at if you can..?

With that patch applied, the reproducer runs clean - no errors - and
gets roughly the same performance (maybe slightly better) as when run
against a 6.18 kernel on the same VM.

Thanks,
-Eric
