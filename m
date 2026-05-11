Received: from mail-dl1-f54.google.com (mail-dl1-f54.google.com [74.125.82.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB3BE402B8E
	for <linux-fsdevel@vger.kernel.org>; Mon, 11 May 2026 15:12:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778512377; cv=pass; b=d1FZpmhTBSdFqDNew0zx6wDtCINgT3L7hqgbxb1zE2YyfIQVU8mMs1aiRZaLqHxVYQPd8AqO3wT3h921avjLGPw99Mr1yMAOVB4kz5QP864ZiQyks+7ERiuwz+OuvXIRd56HFJu41462zSCFq2Hp5fVvWxdvRJE3VZxOFQ/v+II=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778512377; c=relaxed/simple;
	bh=aathsBnbkgVaFXNMwT/mok0vKqK3XEdX4/Ft8nMtbCI=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=ILg7GvpwbXLkWy6FtJ0F00fXgqpLjxX8HbSZkCdzc7dnrFkT8wzo2beEKy38ZW6N0avnE/eSZaO8Xqq4ABlLBqB1sUOA9NNdZZK4b0LHfVulhimAMs73bzio1ff/MZxKS2qnkD3QfRav2X0YEf/PTtCnML9kTw7JsTl6twbGcvk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=o7rgtTcD; arc=pass smtp.client-ip=74.125.82.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="o7rgtTcD"
Received: by mail-dl1-f54.google.com with SMTP id a92af1059eb24-1332772f6b3so745242c88.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 11 May 2026 08:12:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778512375; cv=none;
        d=google.com; s=arc-20240605;
        b=Na20Zves5Zd1eqPVe7I9kt6QDdfJ45Kb20CkPo2fyI8anyijQVpWZi7JOfXjCyubEs
         SHd8pQMG8J37J64w2lMnANaGAEO/MnuR8l1UMguk7f1MGrysxbJk+EYRzlOTeV8Biq1b
         H6P6C47Du8Rr0J1tzVboeB5Qu6OSLXiZopj7vYe2cFfRBI2Zy8vbmxtkwmNDXe0Mjemd
         a/SqQQt+TzHfO9xQVigg0u964FdvDQlX9dLfqpfHWWUwQnzxoXGbSNbIYSv/8BdOPnnm
         AdTb83wCJh2+5u0At5SDL61w6PC/NqOXFVMKB5k8u/UPXFNefMrqhCqY2Y6GceMZF+3J
         iOPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:dkim-signature;
        bh=DVj8x9VSZBK8vc/OEq+ZAApJltFoV5zCcZWj9ipEgF8=;
        fh=iRnN5jp8ufaruPxmsHW+K3ox1pPm2f+/q5h7eKCxDDE=;
        b=G8Uhwil+eB//y9gYfU5irDUKMRDsbrtxrTcw0evWzL/zxXE27Fj7X+yeA1gIZIge5b
         sERa9aPCeMfvX2aqBUWLHqtgJXqtzGj9HBQPSxDTy1yARyBRZ/NCUBo4CzID1dGjFsXR
         Pe3Z7eLUDwIRGW7ifMznJ93ugsP4N0cq7n6wfaGS8Uu/ixzJGuQVHHdqKC6v+HYYGxL6
         Vm83dRInYlnp6ZiHQuIbJoKygYBRyp3Wx56zT+ci4+5WeH3oMMkgPCaKyGOs3Ke2M0ys
         IQLCIFITXab7iVPXQWbWbovVFqkDCmFYkOkxROnCMdgY8bGJenxi2lLfZtRceGn5p8YN
         gTHQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1778512375; x=1779117175; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=DVj8x9VSZBK8vc/OEq+ZAApJltFoV5zCcZWj9ipEgF8=;
        b=o7rgtTcDpSVqogkVaCcK9WH1TQ6ZBAAoUzIsRRuO5o3JR0pebg/oqkHTJw+QmGHp1o
         vbNVGL9gFgaUUT+iH6/pGIbQqNdm7lcUhOLxzjBPUp5z+p0q9L+WKBawrs9/ti/0uIGZ
         qtLnEqWLyeTvushjFj1TUDQG1sRqG8vIbiugw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778512375; x=1779117175;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DVj8x9VSZBK8vc/OEq+ZAApJltFoV5zCcZWj9ipEgF8=;
        b=m9l+g/PLSGm+WCMvMHgBX63NcBkukAUqxcPq2jIXsH8GS6q78d2eVxlNNX0uOhzkNv
         r+SPHmqPUqTjODshD9ZIBpmbUUn9EFkNO7/DrL7bqwt1IVuqbmQLjK4D1rtdbYY7COJl
         9pjIvq8ET04Iv8GQ8sAIiTuHU7VI5HqhxqL25P5/9+irJ2cx2Dcr3YlyM2zWR4Z4XCdS
         q3ZM2dQU+ShblpXrm5Ac9aOwNWSSjpGNUTS2DPL3QERfbCQ9yCE1G9Dvr6SW50GQrMLQ
         08Ynmax/tEPp7SatoxwR37FcPpm8b7zWaH2ekFuVpPruXY5Q2WNL8Oof7QWCA9ZAaoDo
         RU1g==
X-Gm-Message-State: AOJu0YwqDmbCnoFzxyMtgcPiy6cQ1UKTjN0nffvNSWn1tAIlsFrA29IQ
	VZ1UYos0YOlLcX73KJn3giQ091AFn/KdbeGS2vOuiIejfXLQ/FQ7TSLC68QzNDObP+Uy8nyVBhB
	gftWOBysKbUl40lVxc7t5PfmXl+cQKqQ9BFSCD1/d7Q==
X-Gm-Gg: Acq92OHfnHeS4ZlU2C5xFYQLLeuA44vFDBn9trNlZTayTY6NAejAKX10bbDDSuZV/Ju
	BWwB7dISwPs5gRDr3wU29wID/2NadJhoEaUwl6P78fE6eIVCaXzpwPtssWadmzQCEGAZEgooZP4
	clgZH6W6RLNSGOx3hL18vVzMRZhPx8CQnbn6JhYJIxnVWpafvW1vM/c1PH3v+FKNrEVBy4PrUkF
	L/ask050N6ios7WgvNl8LeX9DY+QnUIUq5OthrOFn3zDuJSXZNR26EOap2wsj2p1pAW0Xp4XUVv
	lBzy9xH/QNRt91F3FAwqbTmh60GWZg5r+JaVMAU=
X-Received: by 2002:a05:7022:21d:b0:12a:8ea4:252 with SMTP id
 a92af1059eb24-1317d893837mr11382095c88.4.1778512374558; Mon, 11 May 2026
 08:12:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Mon, 11 May 2026 17:12:42 +0200
X-Gm-Features: AVHnY4LKCTGBPV2-IauLL9M0mSqYuUvrkz-If8dEIBj4Tl7aLqbo-Tkqp3iU-Q8
Message-ID: <CAJfpegvXnA1QpmfM9V+3VB470xYDNWH8FV0mBV1R1-HqvjfJ8A@mail.gmail.com>
Subject: [post LSFMM summary] where is fuse going?
To: fuse-devel <fuse-devel@lists.linux.dev>
Cc: linux-fsdevel@vger.kernel.org, John Groves <John@groves.net>, 
	Joanne Koong <joannelkoong@gmail.com>, "Darrick J . Wong" <djwong@kernel.org>, 
	Amir Goldstein <amir73il@gmail.com>, Bernd Schubert <bernd@bsbernd.com>, 
	Horst Birthelmer <horst@birthelmer.de>, Luis Henriques <luis@igalia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Please let know what I missed.

CO-MAINTAINER:  Position still open, though we formalized some
subsystem maintainership roles, sent MAINTAINERS patch.

FAMFS: Let's try to find some common ground between the fuse-iomap api
and the famfs api.  I.e. add striping as a generic mapping method,
even though normal filesystems don't (currently) use it.  Using BPF is
a bad idea.

FUSE-IOMAP: Need to reduce the scope of the patchset further, as no
one can sanely review it.  Idea: first just implement static maps
(i.e. read-or-re-write-only).  This should be much simpler, yet could
demonstrate a read-only mount of ext4, right?

COMPOUND REQS: let's add this to fusex.  uAPI is simple, kAPI needs refinin=
g.

FILE HANDLES: same: let's add to fusex.

URING BUFFER MANAGEMENT: there's a disagreement between Joanne and
Bernd about this.  I think we first need a very high level description
of each solution and why it's preferred over the other.

LARGE FOLIOS: depends on !strictlimit.  I don't have a good enough
understanding of writeback throttling to decide whether removing the
strictlimit requirement for unprivileged fuse is okay or not.  Need
more analysis.

FUSEX: there was approval for the idea of using this as a uAPI major
version update.  In other words fusex will gain feature parity with
legacy fuse, but with a more consistent interface.

MAILING LIST: we have a shiny new one, there was agreement that it's
sufficient for normal fuse discussion and patch posting, and usually
there's no need to cross post linux-fsdevel.

Amir asked about how long it took for overlayfs to go upstream.  Well,
I looked up both fuse and overlayfs:

fuse first release: Nov 2001
fuse merge: Sep 2005

ovl first patchset: Aug 2010
ovl merge: Oct 2014

Both 4 years =C2=B12 months.

So don't despair! There's light at the end of the tunnel (and
hopefully not the oncoming train ;)

Thanks,
Miklos
