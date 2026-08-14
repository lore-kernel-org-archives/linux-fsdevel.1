Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DB4B43D4FA
	for <linux-fsdevel@vger.kernel.org>; Fri, 14 Aug 2026 08:23:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786695815; cv=none; b=gzeuzzgGo8OQDJFX2Tyl8uOXo3zAbUdM++vwHw2XgvqwUYE1sa0kPmsHaaEHcd09+g+9ZarneDTKLnyG5Kqd04+3VTzy2HM5fUae9MjnMIMDPvDIEMjpEvGOLPMos7n9c9OOz4l8UQcQFn9r6SAv3qJkRd59MUNfcHvY35R2ENY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786695815; c=relaxed/simple;
	bh=AYi6XN6L+ooLAzjDbjw5n6K1PLJzuIAPnkRJZYc6P/o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LbRJ10Hu9QpxUg/SgKTpVTXoMeZ+9X95cnrWkmS2jiV2+7MLl3A/lAoZ8vFQXX1RcYSUVrj4qP3C/QAZJxPg1iBB/kHqj4kTm+eCf898kHzL0aaB7+btIMKZkwK7gyVe9bOmgaLa9+OdlEpR13cEj148hXj43FLWZ8wNRXGwZUc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BFhTdoVE; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BFhTdoVE"
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-38d489b6b71so810284a91.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 14 Aug 2026 01:23:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786695810; x=1787300610; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=mdwrDZQ/B1XCL4tbfkMD/QBVbfJkQDSMykw+X/F3Z3Y=;
        b=BFhTdoVE/SP+i1kwHMJEgyYIPuMkAikZnC11BDcBPHkC551AHeILeFZ1an7uuW9qU5
         qz+UB+EJQIAZwlx6iVwcjbPzIeJl+HEK/SH1QhNNkiJCJPfwiMgmKv8D42rnYvHUtYQG
         rNElNdY39IGavpkE9Z/p3i7Ay3dUOkZtsEuRmO2mlKUHUjTGsoQOMvQ5+q9Ee2aInQx1
         6kkSiYirnDFZW3z2CVptAbxM+5xwOzgovQea4543gS6kBGe7a//Y2Byoc4XCyBdzAjrr
         yUSwtxKTwQc7nPRKUgwtNare55yuWoFVqQ0nGFl++g4u/5JGzfJx/dyeJQKetTjJNEdk
         icOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786695810; x=1787300610;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=mdwrDZQ/B1XCL4tbfkMD/QBVbfJkQDSMykw+X/F3Z3Y=;
        b=PQ2w5FxFQ+lJ8pnPSnp6D0TBxmTxtpvZ9cNrrHXIPZiUUFoP+Ril2ByPtklsBuGP3E
         cX+UPgAEJin0RSJL3G2mMFKq1ywq1rBqLb+1stdBJ7qNWgMCdm0mykyagmKCjBhpjLSd
         JwJyfiRMbG88kNjoh1pEP4fwdRq0C/x3AFwU+kGq67Ak5gLdp/rYF796NKiWd+TFfNK5
         bW8fhV9OvGeEJMal3ssmAxIKG9Y1jYHC05rDWsxEmwhulnAlfX+i/yTZDcFcruuE23Pj
         tzkqU6pV5fK4MCOVZ440KMPQU8V3Ph985HMgH3Nq04liZsyyxaSB3yt8ZxDZZYLko5+I
         EXSQ==
X-Gm-Message-State: AOJu0YwdXo8HvIYeQqAEI/pdZmi4tLC15MbdmTBihFLsgycTMjzjbnig
	MpFdi2hmmFI8Cx4ZVMHLFuKLyg3te30Nq/jLrIqaa5hdq0lQWjcgaSSeezdjX1CGcVA=
X-Gm-Gg: AR+sD13w+joc4c0fg+BMqAWJvLRHXDg4q5Uf4AXwJMU3Nz5jndTQHsETBN6ELgp7zld
	EcePKcp54BYGGqRc8vVdFWik+LQuSOE6rSJjwZPzPCmpc+XMd9Tv6duQCM1X8gU0z8QKbbLqLda
	7brseB1M4rxA8GSGqnd7at773K2UsqsEELXqTpLWUKI8DBPHDPF03au/Q22q8NHUSRKUxqkXcXY
	ZDCqiOzPd645gTPQLKVKsa0l3FmlHps7vHA/hwdGX+9JpUxL8TU7sBNp/ZMlvwmIWQ0VLBu4hzM
	uXY5pOcVlSX3Z9g2tQP0U/moeIdvAQ/wgL5Ky6QND/QP9Ph7/se+l6RzdpelV+2o2m89BQcoQ5/
	wMQ1kkofS1EvBzc5uXM/w6Xp7N/jcPET72NmfHQC+ekNN7PiK7qtzdUIlkAInM/1Ifz41BsQlto
	Md2Hav99NPqpkww6W/d1oxxjlRS26nNHPNCQHOyzlkrY1pCKnLzd/5TWjvPlzAfzDHK690dFIOo
	tApGOHhMkKLwTSHXLJPfjJY3Zw0DHheOHLsxynvrZZz/v6yme+2Q0Snw7pq+S8G9vAMuHVUyj51
	NWOEyTavWd4Pv1gHPsNZe2wZkVFw3k5GVuS+QPn+1cuaj74u79xOAvodPlnVVrA=
X-Received: by 2002:a17:90b:264d:b0:392:b509:b1a5 with SMTP id 98e67ed59e1d1-3933b93e1aamr4664814a91.14.1786695810219;
        Fri, 14 Aug 2026 01:23:30 -0700 (PDT)
Received: from spider.bream-herring.ts.net ([103.252.203.158])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-394ebb888cbsm1588075a91.9.2026.08.14.01.23.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Aug 2026 01:23:29 -0700 (PDT)
From: Matthias Goergens <matthias.goergens@gmail.com>
To: linux-fsdevel@vger.kernel.org
Cc: viro@zeniv.linux.org.uk,
	brauner@kernel.org,
	jack@suse.cz,
	linux-kernel@vger.kernel.org,
	ansgar.loesser@kom.tu-darmstadt.de,
	djwong@kernel.org,
	david@fromorbit.com,
	amir73il@gmail.com
Subject: [PATCH v2 0/1] vfs: add FILE_DEDUPE_RANGE_REPORT_PROGRESS flag to FIDEDUPERANGE
Date: Fri, 14 Aug 2026 16:23:25 +0800
Message-ID: <20260814082326.3756669-1-matthias.goergens@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260805071414.3414870-1-matthias.goergens@gmail.com>
References: <20260805071414.3414870-1-matthias.goergens@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Changes since v1 (<20260805071414.3414870-1-matthias.goergens@gmail.com>):

Darrick is right that bytes_deduped = len predates the VFS hoisting -
the manpage describes the behaviour the patch would introduce, not the
historical default, and deployed consumers (duperemove advances file
offsets by bytes_deduped) depend on the old semantics.  v2 therefore
keeps the default unchanged and gates the truthful behaviour behind a
new flag:

- FILE_DEDUPE_RANGE_REPORT_PROGRESS (the former reserved2 field is now
  flags): bytes_deduped reports the bytes actually deduplicated, and a
  non-zero request shortened to zero fails per destination with -EINVAL
  instead of reporting success with no progress.
- Unknown flag bits are rejected with -EINVAL.

The fstests series will follow in the same shape: the generic/517
golden output stays as it is (unflagged behaviour is unchanged), and
the new test exercises the flag, including one unflagged case pinning
the legacy reporting.

Darrick also notes the manpage is wrong - with the flag in place, the
right fix is to document the flag in ioctl_fideduperange(2) rather than
change the default; a man-pages patch can follow once the flag name and
semantics are settled.

Amir: you reviewed the v1 logic favourably - could you have a look at
the flag shape instead?  In particular: the name
(FILE_DEDUPE_RANGE_REPORT_PROGRESS), the semantics (actual bytes plus
-EINVAL on zero progress), and whether the manpage fix should ride
along with the kernel patch or follow separately.  If this shape works
for you, the Reviewed-by on the flagged behaviour would be very
welcome.
