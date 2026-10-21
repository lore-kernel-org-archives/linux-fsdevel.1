Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=46.105.49.208
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792594373;
	b=Ovk8eZP3hNqT7vuuh/5k9p1//FMsqQIHr8DNY62Oa35n+fvbLmBlg4cVWl3HVPpmtfrb
	 AKe1B0HZvXtPZ4YeAn2AymdTZZSDL6mVnFMvRZkYzTlPYHgHsa9HeRwrfwR8CzizVEIrt
	 25Q2JZWKkib4yRFU1p3HLpGzYhU6TZ2kwJzkMv40jGe2/8Z+2HuP0aAEln7TZfHH1KaB1
	 DDpiJIHu7izwDlFXchPgyA69sozrXo7dZb4YCXYjKemaL/3aWINt9F9xpEg9BV9rIZTgs
	 xN+7i2TUgCPD/uFBRge8NaUHQln0/u4j6ehSZMyMU55EkCvlOBGkRUf5wNe4+rFT0dg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792594373;
	h=DMARC-Filter:Received:Received:Received:X-OVh-ClientIp:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding:x-ovh-tracer-id:X-VR-SPAMSTATE:
	 X-VR-SPAMSCORE:X-VR-SPAMCAUSE:DKIM-Signature;
	bh=rVPeZyjnWTeMFEHm1QO9kLK2bGrC/Twreh09E4sSMVg=;
	b=Eq1R3eM9uQosNchkdADULsutFG1Ll+oamR33d8Zj+W1hp9n3YiJRmumKbhfBgzH80P/W
	 YesHTcOpbU6Stgbc4vSwgjiyX1SnRTm8a3DUkDAXVrmgUMmvgFTEVrqnQwbZLDim4piIB
	 twRa0R500mzois9CtROrofua6W7MsxgpnP3774mLkK20ea3Z7iNLReiiIj+/2LBiO8L10
	 +uhnSs+kXdURlO4vff38YPDR/b3VFQcXtiQR3XoCLfuFPxbl60YwAFTBKy3Z8RKtbWfMx
	 aeWYX13VP825d91siz7+Vpk9/dW8dhOAAORGn+YOEt8MalPNRThvQmpae9duAKMdekw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=medichon.fr;
	spf=pass smtp.mailfrom=medichon.fr;
	dkim=pass header.d=medichon.fr header.i=@medichon.fr header.a=rsa-sha256 header.s=ovhmo3801317-selector1 header.b=mNgoGbMa;
	arc=none smtp.remote-ip=46.105.49.208
Received: from 20.mo581.mail-out.ovh.net (20.mo581.mail-out.ovh.net [46.105.49.208])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B2F8606A31E
	for <linux-fsdevel@vger.kernel.org>; Wed, 21 Oct 2026 14:52:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7B2F8606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=medichon.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=medichon.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=medichon.fr header.i=@medichon.fr header.a=rsa-sha256 header.s=ovhmo3801317-selector1 header.b=mNgoGbMa
Received: from director7.ghost.mail-out.ovh.net (unknown [10.110.43.56])
	by mo581.mail-out.ovh.net (Postfix) with ESMTP id 4j8shY1Vgsz5x55
	for <linux-fsdevel@vger.kernel.org>; Wed, 21 Oct 2026 14:52:45 +0000 (UTC)
Received: from ghost-submission-7ccd8bbbb6-5czf8 (unknown [10.110.101.69])
	by director7.ghost.mail-out.ovh.net (Postfix) with ESMTPS id 8259CC008A;
	Wed, 21 Oct 2026 14:52:44 +0000 (UTC)
Received: from medichon.fr ([37.59.142.110])
	by ghost-submission-7ccd8bbbb6-5czf8 with ESMTPSA
	id j8enFLzR2GrXHAwAman/9w
	(envelope-from <abo@medichon.fr>); Wed, 21 Oct 2026 14:52:44 +0000
Authentication-Results:garm.ovh; auth=pass (GARM-110S0049fa76e51-f67e-46d9-8b0b-c690b20cdbb4,
                    05BFDA4BFEC350FDF8004146BCFDBCA9DF17BA8C) smtp.auth=abo@medichon.fr
X-OVh-ClientIp:88.190.90.129
From: Arnaud Bonnet <abo@medichon.fr>
To: dhowells@redhat.com,
	marc.dionne@auristor.com
Cc: linux-afs@lists.infradead.org,
	linux-fsdevel@vger.kernel.org,
	jkoolstra@xs4all.nl,
	skhan@linuxfoundation.org,
	Arnaud Bonnet <abo@medichon.fr>
Subject: [PATCH v2] afs: Add barriers by using clear_and_wake_up_bit()
Date: Wed, 21 Oct 2026 16:52:32 +0200
Message-ID: <20261021145232.64710-1-abo@medichon.fr>
X-Mailer: git-send-email 2.53.0
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
x-ovh-tracer-id: 15113235925343690334
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: 0
X-VR-SPAMCAUSE: dmFkZTFc76UFrlyWvkoOIBuvljYWYZFP91FI6MNEnmplunOQ+wNtRXQpAORL8rFvON15WZ36scDd4EOWHdN4ekO+VV4Z5WGMJQYl+8JDrX9bR2g7TMlNVadj7oQhXVtrfT+wi5hGzjQb68Ac38REv3A7bxiV2j5DSJzhAncERcvwnPpfiWfR5qKVEQ+3yc+rYrM96xilpIIS4wCbxZRGWN17SnOTJnXAl9QkrrptfvjRoDK0Vf8mY6oX2z9eVcADdsD+yxmhC1WnHlZh3pJqTzyNbXpnJT7hJ39RY55EXeky48u4RUFguideAKNZzmiIkfrWxK5pJxOFOO0YxJmquKm7TLxcsol4StuA7wx3guLP5CxvduzQahgIO6FZdeZC+J3tdgHohZN0lXlaX1PVaU0mmYyntK8gbT+bj8XfamXOJd/f2FZNURxWUdW8AUgpzOMFb3WEdpdIOyMYhyxXIJivoVUCuzH6+I2YGVHidR943JiX3rhI2MaEGaPq9r/z/8q1URbeZzi+b0ZE6ZslKPbbwoqZiFYU8taSW8EITTVh9Mg1+WWzlxk4UjqgNY7qQL37CWuUPO7azJDNdJkG2t2wlhMnEg5ovTiW8tcfy5WA0dbaWK1WZGqYOleFSUEA1YIDB9RyuNuYZDDgQ5c/H3UR4rkxp43JOPuSfgC1OH5x5GiHGA
DKIM-Signature: a=rsa-sha256; bh=rVPeZyjnWTeMFEHm1QO9kLK2bGrC/Twreh09E4sSMVg=;
 c=relaxed/relaxed; d=medichon.fr; h=From; s=ovhmo3801317-selector1;
 t=1792594365; v=1;
 b=mNgoGbMaqZG+cY/DDehJE0nkQurckhKIC9h36vfqtMSAY554QksEM2/WOauuawNzIkO2v81K
 35N7SKV1FZoBpIIc2DIHqWBKQrx3+nXmJ88reY2MyAG5B3FlEe6AQ0CUElK83Tax/AgekzfJJUy
 fFdhhwoXh1casX3tHqsLdZpJ4HysB2cG+5cDCv7hSQjeNBLnZ6yHVGELS0UAq7aRRdYbV9b7CyQ
 TH/itH9P9KyE7L5E18Uf4vXPUEU6ZtdtWLU4GDoBshEbryPOBF54U53HfMRosp7lP08TGgKjq9y
 7u2KG7C8EaTxXOREbmE22T2W/WpuYIiVr4a0rYKptywpQ==

The wake_up_bit() function requires a full memory barrier between the
bit operation and itself. For atomic operations such as
clear_bit_unlock(), it is enough to use a smp_mb__after_atomic()
barrier.

Insert the smp_mb__after_atomic() barrier where missing. When
appropriate, use the clear_and_wake_up_bit() helper which is a wrapper
for the clear_bit_unlock() -> smp_mb__after_atomic() -> wake_up_bit()
sequence.

Fixes: 3bf0fb6f33dd5 ("afs: Probe multiple fileservers simultaneously")
Fixes: d2ddc776a4581 ("afs: Overhaul volume and server record caching and fileserver rotation")
Signed-off-by: Arnaud Bonnet <abo@medichon.fr>
---
Tested by building and manually checking generated assembly.
Depending on the architecture it may:
        1) have no effect,
        2) supplement the release atomic with a full barrier, or
        3) add a redundant but harmless full barrier.
This fixes the second case.

Example in server.c function afs_check_server_record():

- x86: no change in generated code

- arm64(lse):
        mov     x0, 2           # AFS_SERVER_FL_UPDATING (bit 1)
        add     x1, x20, 232    # &server->flags 
        .arch_extension lse
        ldclrl  x0, x0, [x1]    # clear_bit_unlock(), release barrier
.L264:
+       dmb ish                 # full barrier from smp_mb__after_atomic()
        mov     w1, 1
        mov     x0, x19
        bl      wake_up_bit     # wake_up_bit()
        b       .L258           # return success

- rv64(a):
        li      a5,-3                   # ~AFS_SERVER_FL_UPDATING
        addi    a4,s3,232               # &server->flags
        amoand.d.rl zero, a5, 0(a4)     # clear_bit_unlock(), acquire-release
+               fence rw,rw             # redundant smp_mb__after_atomic()
        li      a1,1
        mv      a0,s5
        call    wake_up_bit             # wake_up_bit()
        j       .L279                   # return success

v2) Changes from v1:
        * Added missing smp_mb__after_atomic() in fs/afs/volume.c.
        * Reworked commit message.
        * Added testing procedure description outside of commit message.

 fs/afs/server.c   | 3 +--
 fs/afs/vl_probe.c | 3 +--
 fs/afs/volume.c   | 5 +++++
 3 files changed, 7 insertions(+), 4 deletions(-)

diff --git a/fs/afs/server.c b/fs/afs/server.c
index 189138bd6d71..6953877c25b2 100644
--- a/fs/afs/server.c
+++ b/fs/afs/server.c
@@ -604,8 +604,7 @@ bool afs_check_server_record(struct afs_operation *op, struct afs_server *server
 	if (!test_and_set_bit_lock(AFS_SERVER_FL_UPDATING, &server->flags)) {
 		clear_bit(AFS_SERVER_FL_NEEDS_UPDATE, &server->flags);
 		success = afs_update_server_record(op, server, key);
-		clear_bit_unlock(AFS_SERVER_FL_UPDATING, &server->flags);
-		wake_up_bit(&server->flags, AFS_SERVER_FL_UPDATING);
+		clear_and_wake_up_bit(AFS_SERVER_FL_UPDATING, &server->flags);
 		_leave(" = %d", success);
 		return success;
 	}
diff --git a/fs/afs/vl_probe.c b/fs/afs/vl_probe.c
index 3d2e0c925460..9850e028c44b 100644
--- a/fs/afs/vl_probe.c
+++ b/fs/afs/vl_probe.c
@@ -22,8 +22,7 @@ static void afs_finished_vl_probe(struct afs_vlserver *server)
 		clear_bit(AFS_VLSERVER_FL_RESPONDING, &server->flags);
 	}
 
-	clear_bit_unlock(AFS_VLSERVER_FL_PROBING, &server->flags);
-	wake_up_bit(&server->flags, AFS_VLSERVER_FL_PROBING);
+	clear_and_wake_up_bit(AFS_VLSERVER_FL_PROBING, &server->flags);
 }
 
 /*
diff --git a/fs/afs/volume.c b/fs/afs/volume.c
index 4f79d25ec37f..ca8fec87a01b 100644
--- a/fs/afs/volume.c
+++ b/fs/afs/volume.c
@@ -444,6 +444,11 @@ int afs_check_volume_status(struct afs_volume *volume, struct afs_operation *op)
 			set_bit(AFS_VOLUME_NEEDS_UPDATE, &volume->flags);
 		clear_bit_unlock(AFS_VOLUME_WAIT, &volume->flags);
 		clear_bit_unlock(AFS_VOLUME_UPDATING, &volume->flags);
+		/* Memory barrier must be set between clearing AFS_VOLUME_WAIT and
+		 * wake_up_bit() since clear_bit_unlock() is not a full barrier.
+		 * See wake_up_bit() description for more information.
+		 */
+		smp_mb__after_atomic();
 		wake_up_bit(&volume->flags, AFS_VOLUME_WAIT);
 		_leave(" = %d", ret);
 		return ret;
-- 
2.53.0

