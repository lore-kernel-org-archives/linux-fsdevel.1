Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5605B37D137
	for <linux-fsdevel@vger.kernel.org>; Thu, 23 Apr 2026 17:01:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776963711; cv=pass; b=tRls3r2GcDgm+aY+Ddkd0dfuRB8DStQujOkMHKWWuplxbH6INzKXJ99BnryIEoppeSvK5VbKeH/gmCCyDcqvLQrU2BOuOCa/ZgZNmtC3OZzz5Yw5uYqO8LNIBhqWjHuXlA34c7r0invqw8mXKdoVtgXBVcg47X5LUHBCquKdC/w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776963711; c=relaxed/simple;
	bh=TOn7OaufpVFnTCngKERiD7517EOajGuL0SqpRc86qfg=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=Ec3w0+gVHMev0kGZlCEfP0BQPcnznwfGGPMD6D63VI60CrDkkclSj7WV3jXSXkcjXCLykhy9q0VWJDKy1PXurKVB7Q+tRZYmvASc8Vf1uOtHIJbUn1ZoR69X/zEZsD4t3bTBqEiFZkMIgx61uUc/PAl7ZfX2fqOtR4fK8vanFxg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PdF1PzMo; arc=pass smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PdF1PzMo"
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-b9c603ec2dfso924018866b.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 23 Apr 2026 10:01:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776963708; cv=none;
        d=google.com; s=arc-20240605;
        b=SCUrL2EDpd9YJnOO37ImZg3/NHDjZ9wDejFGexpfRu+YdA6brHYd7Pc3FHAMTEoSjo
         fSkJHe3nNVoUjhAqvnJ1uUuJnILK4cMtjYp5/P+/8WJhOLFWK8I596HLS1ihHTk1CGi4
         KziPQqYd/2Cbxxx5TDv1wYHFvhP2aqjKdZRfpEWKAKzUPqlCiphouKuVUQJFDXYtnExL
         FwxVByipy4wR9cdL71y53V5xEGeOizB+819oI8ZvFjg4bxMuF2r1EDL/ZQksr2hOIQVU
         M3qRpR/m1tLx0lKD4pmN7+dHHR8DHzwjOOBXx3a+7UPgvGTTWdGGAfsN2D905c2LGMFs
         thYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=MR7Evo27Fb9n4uesCJvxrzmJyEK/vZpzgb8CmAsEAsY=;
        fh=6ATvYK+24sV9IUAGjD/+d+AW3W9Mr/eOu+h73Eb0SAc=;
        b=hX6UhB2hjUp0Mop0H97oFvkIbnsaaWL8t1k+EcmDYVRpk/dIkrjRT3GNxeL2It1Zxf
         oygRGf1S9JofJmHM/aC7++V4lW3JUcM7TpHmUF26yW6S9QYZI4NfzErkbMDkcn/DNWMD
         qoF+cvZGtdI6o0qEUXpHXviwOSj/O4noyxHlCeIDoMtsumSge7KBpyxE9rQNikBNwQim
         ++QpYB7bLC8y9fHhOBb5hlisiWnfHl/wPDPqG3pg4IuBauO1lZROI7Fmq2Qs1feV2q6a
         KksChv2Kff5atitw63fhDmIj1riXteIlEkifUB+F8BV2SajGb8JVNBNiPs3DOlfJvUkb
         Dkeg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776963708; x=1777568508; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=MR7Evo27Fb9n4uesCJvxrzmJyEK/vZpzgb8CmAsEAsY=;
        b=PdF1PzMohNRn0isPMagJx9rrY/oepjF5joKh5Zol1v/7Yubwk47gLSdZK0Czm6GULO
         pLOn93YoBenCX+K400L9WTJ53d+HxTuc2zm630KfpLiFwYOMezczStPEksFaCE1z6aPO
         GSuvd0fJn7TY+bBUZBpFtRejchDJ3gRmkd8Gnsg+r3bVQIMQ3Wqt7WXENsUD8fLck773
         85AWE9chzIs/auTrxMNobZEYiWW+7jy9Tm+sjp3d7LyCr2FSYzJtXATEdG1iFBqlX4O/
         gE06LdyvSzfexIcQqrIw98lxjq1LHNVsO4bWGfVjfEvuhmQ5LYdLUoy8fgFJg1tuF7/3
         bWZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776963708; x=1777568508;
        h=to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MR7Evo27Fb9n4uesCJvxrzmJyEK/vZpzgb8CmAsEAsY=;
        b=arv5XtKaBYCaxiwZtErtwktFHY5GpIiyR7KvBDvyw5NW0UElEfD/+k90ObOvEzMV+t
         FAbBAINTMxMbK/vb1fi0vcXl0bS9eWACpJog5JXNNQiSt0Aq8RIwqq13t07LnF3BxmkH
         uQKW1aysEbwbVtgfvZ6Vs4+wzpl++PQM87HkcTpzrhgUN8mEXUMI4d77cmQmEctIWgSq
         nF/BBoB2lUi8+Iec40yfl621oNqOVrxYEj8yx50DykTQ7v+3iJAKIyyvJPJCPmjsebut
         8iMxX4doOywh4bqpjDFISN6jbGagFUXA0bxZf3956r1yKOBTleS6EtvgXKc8fbN27+mV
         FyJQ==
X-Gm-Message-State: AOJu0YwrpsBaCesQlynMRq+ED/poLWJE6Z3pnIFQrZWTbhsjPfr5j89H
	8dXkfXa6Xwe8gMjNgvnv5reP1RgMQTS+oEMM8X7fNBpaOZTIFXQa/753gRg1Pc/rM3Mf7HVOOHH
	bNTM1uoxqhpOL378pDoFYl/JcNOXBoBKfvw==
X-Gm-Gg: AeBDietShosU9USc+dqpqwMMLM8ZZsy2F4YnwjYYgMvAqgH+gRLVLBGa7+P4/GiG2+0
	BKca25FJU0LlvXcW1bK7EbzUD5oFq/O78xpR8alaQ7eqzeIUkwZJP66vzVW1TyN079GTsvWNdHG
	b34ZpMfTciLAy0ZVWaPcnwCSbW+RSbYY9P+kBb/Y+nazvywqw1T2wnmsqsRkt7tuCCr8JytJSOd
	hnyZvy++p73Buq7CKmEFyZHma7DwKWgGodbxvB2gHGt/j2GEEhKLinNUGHRO+ag8gdqMwuo1y+H
	C3AQEWN6cOevt9hC
X-Received: by 2002:a17:907:da7:b0:ba6:4e0f:e396 with SMTP id
 a640c23a62f3a-ba64e0fe8fdmr1021131966b.12.1776963708142; Thu, 23 Apr 2026
 10:01:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Shyam Prasad N <nspmangalore@gmail.com>
Date: Thu, 23 Apr 2026 22:31:37 +0530
X-Gm-Features: AQROBzAXKGkL4wCrc7a7jqx_RwqEbMziZZLN-r7g3-kQL0OMGl7pH-QpRiQgpWw
Message-ID: <CANT5p=oV8kcE6hXPoUVQAYGaiz+2OERoSRLAS6X+q9KJ_8w8YQ@mail.gmail.com>
Subject: "Intent" of VFS lookups
To: linux-fsdevel <linux-fsdevel@vger.kernel.org>, CIFS <linux-cifs@vger.kernel.org>, 
	linux-nfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi all,

Wanted to understand if this is a problem for other filesystems or if
it is specific to SMB protocol?
SMB2+ protocol mandate that open call specifies if the file being
opened is a directory or not (regular file).

This means that during the VFS lookup callback, fs/smb/client needs to
first try open as one type, check the return status and then possibly
do the open as the other type.

From SMB client POV, it would have been good to know from VFS lookup
callback if the current dentry is intended to be a leaf or not. This
would enable the SMB client to decide which type of open to make
first.

Or if there is a clever hack that I'm missing here, I'm open to ideas.

-- 
Regards,
Shyam
