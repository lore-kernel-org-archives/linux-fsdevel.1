Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794486456;
	b=bpjSAhP9LM3yOyV3mQ+XDBYHE46+6mjoSQNbPituxoVVOiCfC+Y+VLOWSgpInz/PVpw6
	 syANIsKcpqvFX1vyErlawD6HCN6OppJ9hBHe6mSJP5vKSqN0lnU/XmcwXf2FCP1uO2zMx
	 uHrh+BYW2EJUYui0NSFfNPlLACDXOnDGwKLi8T/gTFpCcZ8e/hY1oH8ZhOfBAK6q8sbxT
	 l2o3JfjS7EDRkjKaO8sgmfJ3yMo3Ezhl+RmphyzR0+4hHqH1Hwu1idrE+9TyOxFaJlv/3
	 9NELCbV9FSw6NgHS+nXEr9JQJ4pED6EBFw1MdqQemKTQUN3E5lGmgGbcpap0caRvYKw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794486456;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 Received:Received:Received:Received:Message-ID:Date:MIME-Version:
	 User-Agent:Content-Language:To:Cc:From:Subject:Content-Type:
	 Content-Transfer-Encoding:X-TM-AS-GCONF:X-Proofpoint-Reinject:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Info:X-Authority-Analysis:X-Proofpoint-GUID:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=6zIF2mscWWNdqPdPpywMELCgP+4wYM3ffEmTeqpAw4o=;
	b=gJxC8K3DxM+CGAXXd0i8wyL6ugN0aEQfejTbhHUulFCkHFYUPolk06t8KewyOhZSttq3
	 jE11kufLzhA9Bw5b/HuNzRIzPWVRJmWaeWoqPNLzQsTHv3tZusf+VCK8QMTpl6fZVxww/
	 QNaLg622WW+BCHUB6TBcx1ghpNLRodSJlMuNva/DCMlVgLTwmp+sX4Es/k+qKWvM74/0R
	 n8borNMidRr0AUduoUzC/H2amLO9t8UgwmA8hkt2hMCQBKNojdhoCLz+5xTBIbySf7X6U
	 g/gnx71om0gJKeUNgV/+X5fKvwy6T/uhKWgqDihln14BdbqyHrIPrhFZI7+vmNhdUuA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.ibm.com;
	spf=pass smtp.mailfrom=linux.ibm.com;
	dkim=pass header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=kHiIB1bW;
	arc=none smtp.remote-ip=148.163.156.1
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 583A3606A31C;
	Thu, 12 Nov 2026 12:27:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 583A3606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=kHiIB1bW
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AC2iL0A1214781;
	Thu, 12 Nov 2026 12:27:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pp1; bh=6zIF2mscWWNdqPdPpywMELCgP+4w
	YM3ffEmTeqpAw4o=; b=kHiIB1bWyrkRYoH21DvGNfwM6coLugLCAeOYLOo+0O6I
	MSRSgK+Eb0gb7F9h3zi336apegwmAMLE1efwDWvP3D5plkxNxy6CKrC1VisMoz40
	4QuDUsxiBwYjOrAbQPOSHZSaU9Q8/wjXf6gEPzfuZZ1W4K+hEubHrTVXQowhdIys
	ZNnIy2KjW2NDm30seSVwjYETbJpam8hTWn05YoG99D1kvIfJiudEDy6ROUwHU3+L
	IfBerHM3bvrMI4hv4HOHOaFjtlteTKORAGBhNxsVY4Y80msceYTTnB+Gk2XiQyj/
	ttCvSNJILlFas7/Gqdm/wFYt0WT10a4ezX5PNLffEw==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4hsuntfdu4-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 12 Nov 2026 12:27:26 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 6AC8Lvmf097884;
	Thu, 12 Nov 2026 12:27:25 GMT
Received: from smtprelay07.dal12v.mail.ibm.com ([172.16.1.9])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4hvkq0w7sr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 12 Nov 2026 12:27:25 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (smtpav06.dal12v.mail.ibm.com [10.241.53.105])
	by smtprelay07.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6ACCRPWQ26346036
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 12 Nov 2026 12:27:25 GMT
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id F066D58059;
	Thu, 12 Nov 2026 12:27:24 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 31E5058055;
	Thu, 12 Nov 2026 12:27:22 +0000 (GMT)
Received: from [9.61.240.49] (unknown [9.61.240.49])
	by smtpav06.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 12 Nov 2026 12:27:21 +0000 (GMT)
Message-ID: <bc84cb05-55fe-43e7-9a6e-e6bbf2f5a9ff@linux.ibm.com>
Date: Thu, 12 Nov 2026 17:57:20 +0530
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-GB
To: mszeredi@redhat.com, Shuah Khan <shuah@kernel.org>
Cc: luis@igalia.com, amir73il@gmail.com, linux-fsdevel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, nandinih@linux.ibm.com
From: Venkat Rao Bagalkote <venkat88@linux.ibm.com>
Subject: [BUG / BUILD FAILURE] selftests/fuse: build failure with libfuse <
 3.17.0 (RHEL 10 / fuse3-3.16.2)
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTEyMDA0OCBTYWx0ZWRfX0JfJ6hzcRhBo
 3pYzaJxWCP83/cPc0kLSsIDPYdNyeWt8FbyWRuQat9/3XZ2iKw95G177cPiCqpYJ2tf8vfzAK1v
 BHUHeQT9VgxLgGwtPrIW9XG86dP5iBk9B5urNmoApmLLUyRuMn+HNtbu02fmAG5TY2vp3OPZqyA
 lYbrdVyHDqkVjH2vWQDVu6H23HDWtNhzb+wKoKn4jLPSWu5ZvcMgejzDYz+SR0mbaEx7jrcqXhV
 59ToqtEZ+KD40OVTp6DTSbo9QFxaACTg/HYhdMyfuKZdrqJq5wIe1mnBmLOdocp+3QsK9gpkciT
 Q5yZPCcCbmMUVabGdk38GTXGmzNZgPgByNPKrbZJD+Jprcfmtf96OjG/LhIVdEODuP1oKOi907q
 y5OBDT7ZhqsQ25ZZfoXeJWd5zdFXoTALrJ1PwmK98nNgaS83KhJSo8fqYHSY4ku91IJ9Dmgim4J
 N7wmogzN8iSjaOwOHgg==
X-Proofpoint-ORIG-GUID: 5QlD2gsgulIE-MaNq1rxj5110MS0lzWu
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTEyMDA0OCBTYWx0ZWRfX1UvpJ0LrrdRE
 OpEqesTwMy+Eh2HcYAyPJoXqePAAbBSe49rAX4i57i0CGqUSXarIJFXCqGxB9WRn6sNrcEGJ+5A
 CYKwysiMIwfglqKSSzW7MubjHd6u080=
X-Authority-Analysis: v=2.4 cv=euZKXYpX c=1 sm=1 tr=0 ts=6af5b0af cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8
 a=G8bnuFaaA9ZLbBnholgA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: ADQL8XVHLD3II553328d1E9yRtxsIZum
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-12_01,2026-11-11_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 clxscore=1011 suspectscore=0 spamscore=0 priorityscore=1501
 lowpriorityscore=0 bulkscore=0 impostorscore=0 adultscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611120048


Hi Miklos, Luis,


IBM CI has reported a build failure, while building selftests/fuse, due 
to missing definitions in libfuse3 headers.

Environment:

OS: RHEL 10 (ppc64le)
Kernel: upstream (linux-next / mainline)
libfuse package: fuse3-devel-3.16.2-5.el10.ppc64le (pkg-config 
--modversion fuse3 -> 3.16.2)

Build Errors:

In fuse_acl_cache_test.c & fuse_symlink_cache_test.c:

fuse_acl_cache_test.c: In function ‘fs_init’:
fuse_acl_cache_test.c:105:17: error: implicit declaration of function 
‘fuse_set_feature_flag’ [-Wimplicit-function-declaration]
   105 |                 fuse_set_feature_flag(conn, FUSE_CAP_POSIX_ACL);
       |                 ^~~~~~~~~~~~~~~~~~~~~
make: *** [../../lib.mk:226: 
/home/upstreamci/linux/tools/testing/selftests/filesystems/fuse/fuse_acl_cache_test] 
Error 1

In fuse_mnt.c:

fuse_mnt.c: In function ‘test_readdir’:
fuse_mnt.c:51:35: error: ‘FUSE_FILL_DIR_DEFAULTS’ undeclared (first use 
in this function); did you mean ‘FUSE_FILL_DIR_PLUS’?
    51 |         filler(buf, ".", NULL, 0, FUSE_FILL_DIR_DEFAULTS);
       |                                   ^~~~~~~~~~~~~~~~~~~~~~
       |                                   FUSE_FILL_DIR_PLUS
make: *** [../../lib.mk:226: 
/home/upstreamci/linux/tools/testing/selftests/filesystems/fuse/fuse_mnt] 
Error 1


If you happen to fix this, please add below tag.


Reported-by: Venkat Rao Bagalkote <venkat88@linux.ibm.com>

Regards,

Venkat.



