Received: from mail-oi1-f174.google.com (mail-oi1-f174.google.com [209.85.167.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62E74344DB1
	for <linux-fsdevel@vger.kernel.org>; Mon, 22 Jun 2026 18:53:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782154429; cv=pass; b=AZ4gCqbsX4+qHC5zdiaotAcy6aJm2sdmatZCk39+Cv0OEvPAt0oJ0Xh4Rq6EMbNq+9Qhjv34XyAA8eUs/MTDHzVwqMKBMdCAr80jhDtAUyOl0Rodi70iKgwLxxu2xyFvoP3KdAXUobPN5S3SlfYdcxX3B5EO7wTZFeC4i+nMi3U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782154429; c=relaxed/simple;
	bh=D7wFsYVQpTbbI9lGEoI8/zVT0AxSyj3dbo0f1oaPlqY=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=I/0BmGrNks8bnDhh66eLWFcISb2SXQEbFybcNvMG0eqbBZz7tj5csLKqIF4AmQmpFJqVCvFeIPJxAEM2LCLB3L82MWofqU3jhBBI5AtCdQMcUoIwsawy29xFI5YIfHqNOJIsfFIVGzdl9k/R1isR0o5nXh3mfsVBdcmmKZ6tVeA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gJzixe64; arc=pass smtp.client-ip=209.85.167.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gJzixe64"
Received: by mail-oi1-f174.google.com with SMTP id 5614622812f47-4877b2c9e9fso3399533b6e.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 22 Jun 2026 11:53:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782154427; cv=none;
        d=google.com; s=arc-20240605;
        b=OrFlYPdsihi0yP16g8hEbP0/kbVt+r4eKeQ9rGjPMLqQ2esZBtQS4+YdsQqOjFVQ66
         h38fYneYeu5AeQHRuhaqMqgI3Sz4ZvueI1ZrVcRvr1MxYDSUwb48Waacb3ywJi8WFORN
         eWCtuNQGkYifj9eMd0BkfJipckoZkEW94a2b70dwerRIlsGhs8PUPc9BW6gK8Oorlo7t
         wAuIOFdJtQ8sKnEfc87ygynPk5Vf6y2bF6omrUrN+KdA1v0r0V6uwX9O9lIroCx3I70d
         +rOV0aAQQRtiC/cx490HfrZyRmpBhv69bLa/Nn6dKIrXNg0AUlr3turJYn0BCVYWA+UT
         0rbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=D7wFsYVQpTbbI9lGEoI8/zVT0AxSyj3dbo0f1oaPlqY=;
        fh=cWRx2Pyae4Q0eKeKWW780og3R8qPjmUwWCtNLnw/ykI=;
        b=Fks9FKBcVY8fCFiAU6CB1aY+t3sBh4oZoWXlZOkZtJXEKAcbFKDo0C94pFcAAeL2bv
         NF0cOGwqu6LWqeG9KerKx2fXlthpLPX/cjasTUa7y8ZPICunlTuMFaWcgbco288FRq9U
         hx/n1PFH/w9UZT7nYK44h0Ph5ioeVBwDbIJL2hQI3kG2ZNyqS0ickqROGg4AfDhsDuiG
         6vvILTZIt2x+PY0wpdAAk0QfRG0vs9q3cP1FNpSBOCCAOk6rKIufbObAhVPsvJp5z9G2
         U43amW00nEIippJAObrDTQhgiN7pAl4XNyNR+yxf+PJK+HpHQJ2HEhFGU8mvNKnK0uHc
         CCtQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782154427; x=1782759227; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=D7wFsYVQpTbbI9lGEoI8/zVT0AxSyj3dbo0f1oaPlqY=;
        b=gJzixe64EQsWfMFgoenSu43hejgJOw1NjN3vqZtgrGET+L0lKKZClfZMgSKqcsAX2Q
         TfDWcoPOs6k065REZ3GldVQq+br3QXiLZFpFLEpqw5ynaXEzCqsX5gFt7uqTB15EdthH
         0cJAIqWVGetgV8lSMF71OBt9hy05apPHgO9CBljzbkxQH+FJQ9EQO6kSUypoDrVAVDIC
         UdJ+Ln9IZSm/T/eAwg1P88depR/Z6+kx+js37pxUJI/Rc2jubXnMpup+sCKctjhFyxAg
         HBF2PgEn3lBTK20ftOG40ZedvUNjg9h5uCjB7nEz8mTkOpLykDzBrkWsD0p1ATj3353x
         Dbyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782154427; x=1782759227;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=D7wFsYVQpTbbI9lGEoI8/zVT0AxSyj3dbo0f1oaPlqY=;
        b=AU6xlu7Yyda43PG3svQAzDRsIvdJu4QWuKnRTScer2EZ8oYs22TdQ9uPlzYwYQG8Ih
         eReknVy2skEd1Mby3DQ/WHIs/gNbD7VvFm+uK2a9H00ebN+5wKJFRbE6z7CflGOIQiJY
         9bqDA3EVo/49NSAVMysm+uFpgzUPuAtkLbRfYxtJKeIFzpS32z0lKT2D62LVz7muaHew
         bAAu3Dw01V16Xgm1Q4lf+jFl6e+OOtG3u9ezR/Q5CW44upMQBfk0/SSlOa6eg4ExWUbT
         1N8m597AU9lalo0mpubbTbX3w0oCpwpVZ8RoC5L/rOcuJ633kd8lYJY8s3n63iW49Ilc
         P6pg==
X-Gm-Message-State: AOJu0YzBAy/SseSa1hpQ06HeqRbWSyt1Uqm7sZOcn6V/+zWOKM620K5Q
	l6PGpgljzW5um1bZfOQeIr+FkW0D5kpO21hMf0fySc3GU+0o0MZvHXerhiIipRgIEZmsHWmS2EZ
	LEUzLUXLVXwWIZoO3P5pMAHc3rgY8eWkVoA==
X-Gm-Gg: AfdE7ckqiHIbKW1IO1YjeWEGEmzoV8kxeceetPQILrXJSUocW6sho81mVJKZtMpp7Pl
	ynWPl6jZxcJklYcyaX4cDZ1Ir3PoTNqz6iiKGUxsLRn2hggikT/86LHz7yh02XNGG9nZNTMGZhJ
	5fkFUWgL9PqnnYL7myTCk16Gpx4b2b4aMT6WqUfO051Vju+H6zXh8R7lbrAr0zMUZ0WQr27g3kW
	+CF7mGK1wkrJ/gp7R4cp9pk9hmZVBuLySQnfcgWmvuClCOpWJZs1K4Xwj7Ww5ale2TOkcpV
X-Received: by 2002:a05:6808:1513:b0:48d:e956:e3cf with SMTP id
 5614622812f47-48de956f997mr3441842b6e.29.1782154427284; Mon, 22 Jun 2026
 11:53:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Jeremy Bingham <jbingham@gmail.com>
Date: Mon, 22 Jun 2026 11:53:36 -0700
X-Gm-Features: AVVi8CcDgeyIsbPTBowRs_xvDRoPXiw-gLIVJKt6WY8VlRPQPRoQnX2XQDXXICo
Message-ID: <CAMyBmMAg6FmJZRnDwSXaiLOoPQ+Cv_gmrBfiXyCK1o7Dk7Su4Q@mail.gmail.com>
Subject: [RFC] Minix iomap conversion
To: linux-fsdevel@vger.kernel.org
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>
Content-Type: text/plain; charset="UTF-8"

Greetings, all. I recently learned that iomap is now what filesystems
are supposed to start using for block mapping and I/O going forward. I
maintain an out of kernel module for Xiafs (yes, really, and have for
some time) that I'm planning on switching from buffer_head to iomap to
get familiar with the general concepts before doing the same for a
different project I'm working on.

Since the Xiafs and Minix filesystem drivers are very similar to each
other, if I do the conversion for Xiafs it would be very easy to
convert Minix at the same time. Before I do these conversions, though,
I wanted to check and see if anyone else was already working on doing
this for the Minix driver since I don't want to step on anyone's toes.

Thanks,

-j
